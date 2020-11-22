import 'package:flutter/material.dart';
import 'package:time_tracker/app/common_widget/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String text,
    @required String icon,
    double height,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(text != null || icon != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(icon),
              Text(
                text,
                style: TextStyle(color: textColor, fontSize: 15.0),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset(icon),
              ),
            ],
          ),
          color: color,
          onPressed: onPressed,
        );
}
