import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:covidScanner/services/authservice.dart';

class MyButtonStyle extends StatelessWidget {
  MyButtonStyle({this.text, this.goto});
  final Function goto;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 52,
        minWidth: double.infinity,
        color: kPrimaryColor,
        onPressed: goto,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(
          text,
          style: kButtonText,
        ));
  }
}
