import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert' as JSON;

class AppUser {
  AppUser({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  AppUser currentUser();
  Future<void> signOut();
  Stream<AppUser> get authStateChanges;
  Future<AppUser> signInAnonymously();
  Future<AppUser> signInWithGoogle();
  Future<AppUser> signInWithFacebook();
  Future<AppUser> signInWithEmailAndPassword(String email, String pass);
  Future<AppUser> createUserWithEmailAndPassword(String email, String pass);
}

class Auth implements AuthBase {
  final _fireBaseAuth = FirebaseAuth.instance;

  AppUser _userFromFirebase(User user) {
    if (user == null) return null;
    return AppUser(uid: user.uid);
  }

  @override
  Stream<AppUser> get authStateChanges {
    return _fireBaseAuth.authStateChanges.call().map(_userFromFirebase);
  }

  @override
  AppUser currentUser() {
    final user = _fireBaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<AppUser> signInAnonymously() async {
    final authResult = await _fireBaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<AppUser> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final googleAuth = await googleSignInAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await _fireBaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing auth token from google',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABROTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  Future<AppUser> signInWithFacebook() async {
    final facebookLogIn = FacebookLogin();
    final result = await facebookLogIn.logIn(
      ['public_profile'],
    );
    if (result.accessToken != null) {
      final authResult = await _fireBaseAuth.signInWithCredential(
        FacebookAuthProvider.credential(result.accessToken.token),
      );
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
        code: 'ERROR_ABROTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<AppUser> signInWithEmailAndPassword(String email, String pass) async {
    final authResult = await _fireBaseAuth.signInWithEmailAndPassword(
        email: email, password: pass);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AppUser> createUserWithEmailAndPassword(
      String email, String pass) async {
    final authResult = await _fireBaseAuth.createUserWithEmailAndPassword(
        email: email, password: pass);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogIn = FacebookLogin();
    await facebookLogIn.logOut();
    await _fireBaseAuth.signOut();
  }
}
