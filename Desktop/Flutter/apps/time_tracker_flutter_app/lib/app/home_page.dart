import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/customized_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({@required this.auth});
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmLogout(context),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final didRequestLogout = await PlatformAlertDialog(
      title : 'Logout',
      content: 'Are you sure you want to Logout?',
      cancelActionText: 'Cancel',
      actionText: 'Logout',
    ).show(context);
    if(didRequestLogout == true){
      _signOut();
    }
  }
}
