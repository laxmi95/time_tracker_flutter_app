import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/customized_widgets/customized_raised_button.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker App"),
        elevation: 5.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.blueGrey[300],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
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
            height: 8.0,
          ),
          CustomRaisedButton(
            child: Text('Sign in with Google'),
            color: Colors.white,
            borderRadius: 4.0,
            onPressed: () {},
          ),
          CustomRaisedButton(
            child: Text('Sign in with Facebook'),
            color: Colors.white,
            borderRadius: 4.0,
            onPressed: () {},
          ),
          CustomRaisedButton(
            child: Text('Sign in as anonymous'),
            color: Colors.white,
            borderRadius: 4.0,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void _signInWithGoogle() {
    //TODO
  }
}
