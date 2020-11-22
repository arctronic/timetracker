import 'package:flutter/material.dart';
import 'package:time_tracker/app/common_widget/custom_raised_button.dart';
import 'package:time_tracker/app/sign_in/sign_in_btn.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        backgroundColor: Colors.brown,
        elevation: 5.0,
      ),
      body: _buildContent(),
    );
  }
}

Widget _buildContent() {
  return Padding(
    // /color: Colors.blue[100],
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Sign in',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.0),
        signInButton(
          text: 'Sign in with Google',
          textColor: Colors.black87,
          color: Colors.white,
          height: 50.0,
          onPressed: () {},
        ),
        SizedBox(height: 8.0),
        signInButton(
          text: 'Sign in with Facebook',
          textColor: Colors.white,
          color: Color(0xFF334D92),
          height: 50.0,
          onPressed: () {},
        ),
        SizedBox(height: 8.0),
        signInButton(
          text: 'Sign in with E-mail',
          textColor: Colors.white,
          color: Colors.brown,
          height: 50.0,
          onPressed: () {},
        ),
        SizedBox(height: 8.0),
        Text('Or',style: TextStyle(fontSize: 18.0),textAlign: TextAlign.center,),
        SizedBox(height: 8.0),
        signInButton(
          text: 'Go Annonymous',
          textColor: Colors.white,
          color: Colors.redAccent,
          height: 50,
          onPressed: (){},
        )
      ],
    ),
  );
}
