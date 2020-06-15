import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

import 'email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  EmailSignInPage({@required this.auth});
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
        elevation: 5.0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
          child: EmailSignInForm(auth: auth),
          ),
      ),
      backgroundColor: Colors.blueGrey[100],
    );
  }

}
