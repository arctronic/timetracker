import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/emailSignInPage.dart';
import 'package:time_tracker/app/sign_in/sign_in_btn.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_btn.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/auth_provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;
  Future signInAnon(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context);
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future signInWithGoogle(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context);
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future signInWithFacebook(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context);
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void signInWithEmail(BuildContext context) {
    //final auth = AuthProvider.of(context);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
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
            SizedBox(height: 50.0, child: _buildHeader()),
            SizedBox(height: 8.0),
            SocialSignInButton(
              icon: 'assets/google.png',
              text: 'Sign in with Google',
              textColor: Colors.black87,
              color: Colors.white,
              height: 50.0,
              onPressed: _isLoading? null : () => signInWithGoogle(context),
            ),
            SizedBox(height: 8.0),
            SocialSignInButton(
              icon: 'assets/facebook.png',
              text: 'Sign in with Facebook',
              textColor: Colors.white,
              color: Color(0xFF334D92),
              height: 50.0,
              onPressed:_isLoading? null : () => signInWithFacebook(context),
            ),
            SizedBox(height: 8.0),
            signInButton(
              text: 'Sign in with E-mail',
              textColor: Colors.white,
              color: Colors.brown,
              height: 50.0,
              onPressed:_isLoading? null : () => signInWithEmail(context),
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
              onPressed:_isLoading? null : () => signInAnon(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Text(
        'Sign in',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }
}
