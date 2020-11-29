import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker/app/common_widget/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog(
      {@required String title, @required PlatformException exception})
      : super(
            title: title, content: exception.message, defaultActionText: 'Ok');

  static String _message(PlatformException e) {
    return e.message;
  }
}
