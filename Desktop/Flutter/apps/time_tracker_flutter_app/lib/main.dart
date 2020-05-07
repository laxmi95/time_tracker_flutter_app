import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/landing_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

void main() {
  runApp(MyApplication());
}

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter application',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
