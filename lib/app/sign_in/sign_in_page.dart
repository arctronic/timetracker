import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/emailSignInPage.dart';
import 'package:time_tracker/app/sign_in/sign_in_btn.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_btn.dart';
import 'package:time_tracker/services/auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({@required this.auth});
  
  final AuthBase auth;
  
  Future signInAnon() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future signInWithFacebook() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  void signInWithEmail(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(auth: auth,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        backgroundColor: Colors.brown,
        elevation: 5.0,
        centerTitle: true,
      ),
      body: Padding(
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
            SocialSignInButton(
              icon: 'assets/google.png',
              text: 'Sign in with Google',
              textColor: Colors.black87,
              color: Colors.white,
              height: 50.0,
              onPressed: signInWithGoogle,
            ),
            SizedBox(height: 8.0),
            SocialSignInButton(
              icon: 'assets/facebook.png',
              text: 'Sign in with Facebook',
              textColor: Colors.white,
              color: Color(0xFF334D92),
              height: 50.0,
              onPressed: signInWithFacebook,
            ),
            SizedBox(height: 8.0),
            signInButton(
              text: 'Sign in with E-mail',
              textColor: Colors.white,
              color: Colors.brown,
              height: 50.0,
              onPressed: ()=> signInWithEmail(context),
            ),
            SizedBox(height: 8.0),
            Text(
              'Or',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            signInButton(
              text: 'Go Annonymous',
              textColor: Colors.white,
              color: Colors.redAccent,
              height: 50,
              onPressed: signInAnon,
            ),
          ],
        ),
      ),
    );
  }
}
