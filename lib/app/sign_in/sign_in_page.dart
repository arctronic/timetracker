import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/emailSignInPage.dart';
import 'package:time_tracker/app/sign_in/sign_in_bloc.dart';
import 'package:time_tracker/app/sign_in/sign_in_btn.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_btn.dart';
import 'package:time_tracker/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.bloc}) : super(key: key);
  final SignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
          builder: (context, bloc, _) => SignInPage(
                bloc: bloc,
              )),
    );
  }

  Future signInAnon(BuildContext context) async {
    // final bloc = Provider.of<SignInBloc>(context);
    try {
      await bloc.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future signInWithGoogle(BuildContext context) async {
    // final bloc = Provider.of<SignInBloc>(context);
    try {
      await bloc.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future signInWithFacebook(BuildContext context) async {
    // final bloc = Provider.of<SignInBloc>(context);
    try {
      await bloc.signInWithFacebook();
    } catch (e) {
      print(e.toString());
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
    final bloc = Provider.of<SignInBloc>(context);
    bool isLoading = bloc.loadingState();
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        backgroundColor: Colors.brown,
        elevation: 5.0,
        centerTitle: true,
      ),
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
          initialData: false,
          builder: (context, snapshot) {
            return Padding(
              // /color: Colors.blue[100],
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50.0, child: _buildHeader(snapshot.data)),
                  SizedBox(height: 8.0),
                  SocialSignInButton(
                    icon: 'assets/google.png',
                    text: 'Sign in with Google',
                    textColor: Colors.black87,
                    color: Colors.white,
                    height: 50.0,
                    onPressed:
                        snapshot.data ? null : () => signInWithGoogle(context),
                  ),
                  SizedBox(height: 8.0),
                  SocialSignInButton(
                    icon: 'assets/facebook.png',
                    text: 'Sign in with Facebook',
                    textColor: Colors.white,
                    color: Color(0xFF334D92),
                    height: 50.0,
                    onPressed:
                        isLoading ? null : () => signInWithFacebook(context),
                  ),
                  SizedBox(height: 8.0),
                  signInButton(
                    text: 'Sign in with E-mail',
                    textColor: Colors.white,
                    color: Colors.brown,
                    height: 50.0,
                    onPressed:
                        snapshot.data ? null : () => signInWithEmail(context),
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
                    onPressed: snapshot.data ? null : () => signInAnon(context),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 5.0,
        ),
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
