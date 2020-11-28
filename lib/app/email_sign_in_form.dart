import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

enum SignInFormType { sign, reg }

class EmailSignInForm extends StatefulWidget {
  EmailSignInForm({@required this.auth});
  final AuthBase auth;
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  SignInFormType _formType = SignInFormType.sign;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String get _email => _emailController.text;
  String get _pass => _passwordController.text;

  void _submit() async {
    try {
      if (_formType == SignInFormType.sign)
        await widget.auth.signInWithEmailAndPassword(_email, _pass);
      else
        await widget.auth.createUserWithEmailAndPassword(_email, _pass);
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _toogleFormType() {
    setState(() {
      _formType = _formType == SignInFormType.sign
          ? SignInFormType.reg
          : SignInFormType.sign;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText =
        _formType == SignInFormType.sign ? 'Sign In' : 'Create an account';
    final secondaryText = _formType == SignInFormType.sign
        ? 'Need an account? Register'
        : 'Have an account? Sign In';

    return [
      TextFormField(
        //onChanged: (val) => email = val,
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@email.com',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.brown,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.brown,
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
      SizedBox(height: 16.0),
      TextFormField(
        controller: _passwordController,
        obscureText: true,
        validator: (val) =>
            val.length < 8 ? 'Password must be 8 chars long' : null,
        decoration: InputDecoration(
          labelText: 'Password',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.brown,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.brown,
              width: 1.5,
            ),
          ),
        ),
      ),
      SizedBox(height: 10.0),
      RaisedButton(
        child: Text(primaryText),
        color: Colors.brown,
        textColor: Colors.white,
        focusElevation: 5.0,
        focusColor: Colors.brown[400],
        onPressed: _submit,
      ),
      //SizedBox(height: 5.0),
      FlatButton(
          onPressed: _toogleFormType,
          child: Text(
            secondaryText,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.redAccent,
            ),
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }
}
