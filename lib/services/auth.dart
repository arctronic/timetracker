import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUser {
  AppUser({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  AppUser currentUser();
  Future<AppUser> signInAnonymously();
  Future<void> signOut();
  Stream<AppUser> get authStateChanges;
}

class Auth implements AuthBase {
  final _fireBaseAuth = FirebaseAuth.instance;

  AppUser _userFromFirebase(User user) {
    if (user == null) return null;
    return AppUser(uid: user.uid);
  }

  @override
  Stream<AppUser> get authStateChanges{
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

  @override
  Future<void> signOut() async {
    await _fireBaseAuth.signOut();
  }
}
