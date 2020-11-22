import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({this.height:50.0,this.child, this.color, this.radius : 8.0, this.onPressed});
  final Widget child;
  final double height;
  final Color color;
  final double radius;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        child: child,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        elevation: 5.0,
        onPressed: onPressed,
      ),
    );
  }
}
