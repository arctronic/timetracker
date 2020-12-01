import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/home_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';
import 'package:time_tracker/services/auth.dart';
class LandingPage extends StatelessWidget {
  
  // AppUser _user;

  // @override
  // void initState() {
  //   super.initState();
  //   AppUser user = widget.auth.currentUser();
  //   widget.auth.authStateChanges.listen((user) {
  //     print('User: ${user?.uid}');
  //   });
  // }

  // void _updateUser(AppUser user) {
  //   setState(() {
  //     _user = user;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthBase>(context);

    return StreamBuilder<AppUser>(
        stream: auth.authStateChanges,
        builder: (context, snapshot) {
          //snapshot.connectionState;
          if (snapshot.connectionState == ConnectionState.active) {
            AppUser user = snapshot.data;
            if (user == null) {
              return SignInPage.create(context);
            }
            return HomePage();
          }else{
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
