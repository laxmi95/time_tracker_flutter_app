import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter_course/app/sign_in/social_sign_in.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

import 'email_sign_in.dart';


class SignInPage extends StatelessWidget {

  SignInPage({@required this.auth});
  final AuthBase auth;

  Future<void> _signInAnonymously() async{
    try {
      await auth.signInAnonymously();
    } catch(e){
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async{
    try {
      await auth.signInWithGoogle();
    } catch(e){
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => EmailSignInPage(auth: auth),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker App"),
        elevation: 5.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.blueGrey[100],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 45.0,
            ),
            SocialSignInButton(
              assetName: 'images/google-logo.png',
              text: 'Sign in with Google',
              color: Colors.white,
              onPressed: _signInWithGoogle,
            ),
            SizedBox(
              height: 8.0,
            ),
            SocialSignInButton(
              assetName: 'images/facebook-logo.png',
              text: 'Sign in with Facebook',
              textColor: Colors.white,
              color: Color(0xFF334D92),
              onPressed: () {},
            ),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              text: 'Sign in with email',
              textColor: Colors.white,
              color: Colors.teal[600],
              onPressed: () => _signInWithEmail(context),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'OR',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              text: 'Go anonymous',
              color: Colors.lime,
              onPressed: _signInAnonymously,
            ),
          ],
        ),
      ),
    );
  }
}
