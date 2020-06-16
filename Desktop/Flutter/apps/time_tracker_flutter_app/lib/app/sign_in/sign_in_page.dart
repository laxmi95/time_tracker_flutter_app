import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter_course/app/sign_in/social_sign_in.dart';
import 'package:time_tracker_flutter_course/customized_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:flutter/services.dart';
import 'email_sign_in.dart';


class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool _isLoading = false;

  void _showSignInErrorMessages(BuildContext context, PlatformException exception){
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async{
    setState(() => _isLoading = true);
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signInAnonymously();
    } on PlatformException catch(e){
      _showSignInErrorMessages(context, e);
    } finally{
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async{
    setState(() => _isLoading = true);
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signInWithGoogle();
    } on PlatformException catch(e){
      if(e.code != 'ERROR_ABORTED_BY_USER')
      _showSignInErrorMessages(context, e);
    }finally{
      setState(() => _isLoading = false);
    }
  }

  void _signInWithEmail(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => EmailSignInPage(),
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
            SizedBox(
                height: 50.0 ,
                child: _buildHeader(),
            ),
            SizedBox(
              height: 45.0,
            ),
            SocialSignInButton(
              assetName: 'images/google-logo.png',
              text: 'Sign in with Google',
              color: Colors.white,
              onPressed: _isLoading ? null : () => _signInWithGoogle(context),
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
              onPressed: _isLoading ? null : () => _signInWithEmail(context),
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
              onPressed: _isLoading ? null : () => _signInAnonymously(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(){
    if(_isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return  Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
