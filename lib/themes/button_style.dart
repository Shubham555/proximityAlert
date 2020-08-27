import 'package:flutter/material.dart';
import 'constants.dart';

class ButtonStyle extends StatelessWidget {
  ButtonStyle({this.text, this.goto});
  final String goto;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 52,
        minWidth: double.infinity,
        color: kPrimaryColor,
        onPressed: () => {Navigator.pushNamed(context, goto)},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(
          text,
          style: kButtonText,
        ));
  }
}
