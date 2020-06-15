abstract class StringValidator{

  bool isValid(String value);

}

class NonEmptyStringValidator implements StringValidator{
  @override
  bool isValid(String value){
    return value.isNotEmpty;
  }

}

class EmailPasswordValidator{
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email cannot be empty';
  final String invalidPasswordErrorText = 'Password cannot be empty';

}