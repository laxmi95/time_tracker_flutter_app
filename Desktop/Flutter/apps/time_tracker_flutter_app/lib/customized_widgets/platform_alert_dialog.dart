
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:time_tracker_flutter_course/customized_widgets/platform_widgets.dart';


class PlatformAlertDialog extends PlatformWidget{
  PlatformAlertDialog({
    @required this.title,
    @required this.content,
    this.cancelActionText,
    @required this.actionText}) : assert(title != null), assert(content != null) , assert(actionText != null);

  final String title;
  final String content;
  final String cancelActionText;
  final String actionText;

  Future<bool> show(BuildContext context) async{

    return Platform.isIOS ?
    await showCupertinoDialog<bool>(
        context: context,
        builder: (context) => this,
     )
     : await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => this,
    );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context){
    final actions = <Widget>[];
    if(cancelActionText != null){
      actions.add(
          PlatformAlertDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
      );
    }
    actions.add(
      PlatformAlertDialogAction(
          child: Text(actionText),
          onPressed: () => Navigator.of(context).pop(true),
      )
    );
    return actions;
  }

}


class PlatformAlertDialogAction extends PlatformWidget{
  PlatformAlertDialogAction({this.child, this.onPressed});
  final Widget child;
  final VoidCallback onPressed;


  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }
  
}