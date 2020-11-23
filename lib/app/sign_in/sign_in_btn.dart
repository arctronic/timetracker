import 'package:flutter/cupertino.dart';
import 'package:time_tracker/app/common_widget/custom_raised_button.dart';
import 'package:flutter/material.dart';

class signInButton extends CustomRaisedButton {
  signInButton({
    String text,
    double height,
    double BorderRadius:10.0,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : assert(BorderRadius!=null),
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
