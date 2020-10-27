import 'package:flutter/material.dart';

import 'email_sign_in_form_bloc_based.dart';
import 'email_sign_in_form_stateful.dart';

class EmailSignInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
        elevation: 5.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
            child: EmailSignInFormBlocBased.create(context),
            ),
        ),
      ),
      backgroundColor: Colors.blueGrey[100],
    );
  }

}
