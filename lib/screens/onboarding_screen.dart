import 'package:covidScanner/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/bg_clipper.dart';
import 'package:covidScanner/themes/button_style.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print(height);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(30, height * 0.03, 30, height * 0.09),
              child: Text(
                "Welcome To\nOur App",
                style: kRegisterTitle,
                textAlign: TextAlign.left,
              ),
            ),
            ClipPath(
              child: Container(
                child: Image.asset(
                  'assets/images/get-started.png',
                ),
                height: height * 0.45,
                color: kCurveBgColor,
              ),
              clipper: DoubleClipper(),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.12),
              child: Center(
                child: Text(
                  "Join us in our Journey !",
                  style: kguideText.copyWith(fontSize: 24),
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.fromLTRB(30, height * 0.042, 30, height * 0.03),
              child: Center(
                child: ButtonStyle('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
