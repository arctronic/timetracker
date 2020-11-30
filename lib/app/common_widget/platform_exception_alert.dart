import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker/app/common_widget/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog(
      {@required String title, @required PlatformException exception})
      : super(
            title: title, content:  _message(exception), defaultActionText: 'Ok');

  static String _message(PlatformException e) {
    print(e.code);
    return _errors[e.code] ?? e.message;
  }

  static Map<String, String> _errors = {
    'expired-action-code': 'The action code has expired.',
    'invalid-action-code':
        'The action code is invalid. This can happen if the code is malformed or has already been used.',
    'user-disabled':
        'The user corresponding to the given action code has been disabled.',
    'user-not-found':
        'There is no user corresponding to the action code. This may have happened if the user was deleted between when the action code was issued and when this method was called.',
    'weak-password': 'The new password is not strong enough.'
  };
}
