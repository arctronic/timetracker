import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:time_tracker/services/auth.dart';

class SignInBloc {
  SignInBloc({@required this.auth});

  final AuthBase auth;

  final StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) {
    _isLoadingController.add(isLoading);
  }

  bool loadingState() {
    if (isLoadingStream == true)
      return true;
    else
      return false;
  }

  Future<AppUser> _signIn(Future<AppUser> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      rethrow;
    } finally {
      _setIsLoading(false);
    }
  }

  Future<AppUser> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);
  Future<AppUser> signInWithGoogle() async =>
      await _signIn(auth.signInWithGoogle);
  Future<AppUser> signInWithFacebook() async =>
      await _signIn(auth.signInWithFacebook);
}
