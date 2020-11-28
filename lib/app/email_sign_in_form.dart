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
  bool _isLoading = false;

  void _submit() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_formType == SignInFormType.sign)
        await widget.auth.signInWithEmailAndPassword(_email, _pass);
      else
        await widget.auth.createUserWithEmailAndPassword(_email, _pass);
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
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
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          enabled: _isLoading == false,
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
        textInputAction: TextInputAction.next,
        obscureText: true,
        decoration: InputDecoration(
          enabled: _isLoading == false,
          labelText: 'Password',
          //errorText: _passwordController.text.length < 8 && submitted? 'Please enter atleast 8 chars!':null,
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
        onPressed: !_isLoading ? _submit : null,
      ),
      //SizedBox(height: 5.0),
      FlatButton(
          onPressed: !_isLoading ? _toogleFormType : null,
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
