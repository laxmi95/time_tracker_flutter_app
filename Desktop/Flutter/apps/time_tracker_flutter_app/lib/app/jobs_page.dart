import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:time_tracker_flutter_course/customized_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/customized_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

class JobsPage extends StatelessWidget {

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _createJob(BuildContext context) async{
    try{
      final database = Provider.of<Database>(context);
      await database.createJob(Job(name : 'Marketing' , ratePerHour : 10));
    } on PlatformException catch(e){
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
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
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add) ,
          onPressed: () => _createJob(context),
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
      _signOut(context);
    }
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: database.jobStream(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          final jobs = snapshot.data;
          final children = jobs.map((job) => Text(job.name)).toList();
          return ListView(children: children);
        }
        return Center(child : CircularProgressIndicator());
      },
    );
  }


}
