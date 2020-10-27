
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

import 'email_sign_in_model.dart';

class EmailSignInBloc{

  EmailSignInBloc({@required this.auth});
  final AuthBase auth;
  final StreamController<EmailSignInModel> _streamController = StreamController<EmailSignInModel>();
  Stream<EmailSignInModel> get modelStream => _streamController.stream;
  EmailSignInModel _emailSignInModel = new EmailSignInModel();

  void dispose(){
    _streamController.close();
  }

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }){
    // update model
     _emailSignInModel = _emailSignInModel.copyWith(
      email: email,
       password: password,
       formType: formType,
       isLoading: isLoading,
       submitted: submitted,
     );
    // add updated model to _streamController
    _streamController.add(_emailSignInModel);

  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void toggleFormType(){
    updateWith(
      email: '',
      password: '',
      formType: _emailSignInModel.formType == EmailSignInFormType.signIn ? EmailSignInFormType.register : EmailSignInFormType.signIn,
      isLoading: false,
      submitted: false,
    );
  }

  Future<void> submit() async{
   updateWith(submitted: true , isLoading: true);
    try {
      if (_emailSignInModel.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_emailSignInModel.email, _emailSignInModel.password);
      } else {
        await auth.createUserWithEmailAndPassword(_emailSignInModel.email, _emailSignInModel.password);
      }
    } catch(e){
      updateWith(isLoading: false);
      rethrow;
    }
  }

}