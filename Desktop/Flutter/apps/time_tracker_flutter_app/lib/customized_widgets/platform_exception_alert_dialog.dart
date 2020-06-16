import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker_flutter_course/customized_widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog{
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
    title: title,
    content: _message(exception),
    actionText: 'OK',
  );

  static String _message(PlatformException exception){
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {

  'ERROR_WRONG_PASSWORD' :'The password is invalid',
    ///   • `ERROR_WEAK_PASSWORD` - If the password is not strong enough.
    ///   • `ERROR_INVALID_EMAIL` - If the email address is malformed.
    ///   • `ERROR_EMAIL_ALREADY_IN_USE` - If the email is already in use by a different account.
    ///     ///   • `ERROR_INVALID_CREDENTIAL` - If the [email] address is malformed.

    ///   • `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
    ///   • `ERROR_USER_NOT_FOUND` - If there is no user corresponding to the given [email] address.
    ///   • `ERROR_NOT_ALLOWED` - Indicates that email and email sign-in link
    ///      accounts are not enabled. Enable them in the Auth section of the
    ///      Firebase console.
    ///   • `ERROR_DISABLED` - Indicates the user's account is disabled.
    ///   • `ERROR_INVALID` - Indicates the email address is invalid.
    ///   ///   • `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
    ///   • `ERROR_USER_NOT_FOUND` - If there is no user corresponding to the given [email] address, or if the user has been deleted.
  };
}