import 'package:flutter/material.dart';

WidgetBuilder confirmDialogBuilder({@required String message, @required VoidCallback onSuccess}) {
  return (BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text('No'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      textColor: Colors.red,
      child: Text('Yes'),
      onPressed: () {
        Navigator.of(context).pop();
        onSuccess();
      },
    );

    // set up the AlertDialog
    return AlertDialog(
      title: Text('Confirm'),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  };
}
