

import 'package:flutter/material.dart';

import 'customized_raised_button.dart';

class FormSubmitButton extends CustomRaisedButton{
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
}) : super(
    child : Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 20.0),
    ),
      height: 40.0,
      color: Colors.indigo,
      borderRadius:4.0,
      onPressed: onPressed,
  );
}