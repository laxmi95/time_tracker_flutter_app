import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/landing_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApplication());
}

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
//      builder: (context) => Auth(),  // removing builder as it is deprecated from version 3.2 & 4.x onwards
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'My Flutter application',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: LandingPage(),
      ),
    );
  }
}
