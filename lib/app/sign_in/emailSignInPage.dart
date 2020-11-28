import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/email_sign_in_form.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/auth_provider.dart';


class EmailSignInPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 10.0,
            child: EmailSignInForm(),
          ),
        ),
      ),
      
    );
  }
}
