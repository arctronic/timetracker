import 'package:flutter/cupertino.dart';
import 'package:time_tracker/app/common_widget/custom_raised_button.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class signInButton extends CustomRaisedButton {
  signInButton({
    String text,
    double height,
    // ignore: non_constant_identifier_names
    double BorderRadius: 10.0,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(BorderRadius != null),
        super(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 15.0,
            ),
          ),
          color: color,
          borderRadius: BorderRadius,
          onPressed: onPressed,
          height: height,
        );
}
