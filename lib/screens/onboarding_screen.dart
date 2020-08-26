import 'package:covidScanner/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/bg_clipper.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ClipPath(
            child: Container(
              height: 350,
              color: kCurveBgColor,
            ),
            clipper: WavyClipper(),
          ),
        ),
      ),
    );
  }
}
