import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker/app/common_widget/platform_exception_alert.dart';
import 'package:time_tracker/app/sign_in/emailSignInModel.dart';
import 'package:time_tracker/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth, EmailSignInBloc bloc});
  final AuthBase auth;
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (_model.formType == SignInFormType.sign)
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      else
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
    }catch (e) {
      rethrow;
    } finally {
      updateWith(isLoading: false);
    }
  }

  void updateWith(
      {String email,
      String password,
      SignInFormType formType,
      bool isLoading,
      bool submitted}) {
    // update model
    //add updated model
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );

    _modelController.add(_model);
  }
}
