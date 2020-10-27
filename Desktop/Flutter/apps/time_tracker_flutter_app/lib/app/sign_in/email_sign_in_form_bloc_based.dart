import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/validators.dart';
import 'package:time_tracker_flutter_course/customized_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/customized_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:flutter/services.dart';

import 'email_sign_in_bloc.dart';
import 'email_sign_in_model.dart';


class EmailSignInFormBlocBased extends StatefulWidget {
  EmailSignInFormBlocBased( {@required this.bloc} );
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context){
    final AuthBase auth = Provider.of<AuthBase>(context);
    return Provider<EmailSignInBloc>(
      builder: (context) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
        builder: (context, bloc , _) => EmailSignInFormBlocBased(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormBlocBased createState() => _EmailSignInFormBlocBased();
}

class _EmailSignInFormBlocBased extends State<EmailSignInFormBlocBased> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();



  @override
  void dispose(){
    print('widget disposed and therefore widget removed from widget tree');
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async{
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on PlatformException catch(e){
      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    }
  }

  void _onEditingComplete(EmailSignInModel model){
    final focusNew = model.emailValidator.isValid(model.email) ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(focusNew);
  }

  void _toggleFormType(){
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model){
    return[
      _buildEmailTextField(model),
      SizedBox(height: 8.0),
      _buildPasswordTextField(model),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(model.secondaryButtonType),
        onPressed: !model.isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
//      onChanged: (password) => widget.bloc.updatePassword(password),
      onChanged: widget.bloc.updatePassword,
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: model.invalidEmailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: widget.bloc.updateEmail,
      onEditingComplete: () => _onEditingComplete(model),
    );
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
      stream: widget.bloc.modelStream,
      initialData: EmailSignInModel(),
      builder: (context, snapshot){
        final EmailSignInModel model = snapshot.data;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        //MainAxisSize default is max
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(model),
      ),
    );
  }
    );
  }

}
