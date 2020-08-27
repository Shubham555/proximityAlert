import 'package:covidScanner/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/bg_clipper.dart';
import 'package:covidScanner/themes/button_style.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              child: Container(
                height: height * 0.32,
                color: kCurveBgColor,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Text(
                    "Verify your\nphone number",
                    style: kRegisterTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              clipper: BottomClipper(),
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: Text(
                "We'll send an OTP to\nyour mobile number for verification",
                style: kguideText,
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: height * 0.02),
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextField(
                  maxLength: 10,
                  decoration: InputDecoration(
                    prefixText: "+91",
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                margin:
                    EdgeInsets.fromLTRB(0, height * 0.02, 0, height * 0.045),
                child: ButtonStyle('Next')),
            Image.asset(
              'assets/images/otp-sent.png',
            )
          ],
        ),
      ),
    ));
  }
}
