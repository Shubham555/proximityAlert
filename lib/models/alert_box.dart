import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';

showAlertDialog(BuildContext context, String text) {
  // Create button
  Widget okButton = FlatButton(
    child: Text(
      "OK",
      style: kAlertBoxTitle,
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      text,
      style: kAlertBoxTitle,
    ),
    // content: Text("This is an alert message.")
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
