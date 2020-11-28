import 'package:flutter/material.dart';
import 'package:time_tracker/app/email_sign_in_form.dart';
import 'package:time_tracker/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  EmailSignInPage({@required this.auth});
  final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        elevation: 5.0,
        centerTitle: true,
      ),
      body: Card(
        child: EmailSignInForm(auth: auth,),
      ),
    );
  }
}
