import 'package:covidScanner/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/bg_clipper.dart';
import 'package:covidScanner/themes/button_style.dart';

class IdentificationScreen extends StatelessWidget {
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
                height: height * 0.28,
                color: kCurveBgColor,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Text(
                    "Your\nIdentification",
                    style: kRegisterTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              clipper: BottomClipper(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Upload an image of your\nAadhar Card",
                style: kguideText,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height * 0.03),
                color: kTextFieldBgColor,
              ),
              height: height * 0.16,
              width: height * 0.16,
              child: MaterialButton(
                onPressed: null,
                child: Image.asset('assets/images/upload.png'),
              ),
            ),
            //TODO:Add upload aadhar card button here
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                margin:
                    EdgeInsets.fromLTRB(0, height * 0.02, 0, height * 0.025),
                child: ButtonStyle(
                  text: 'Upload',
                )),
            Image.asset(
              'assets/images/adhar-card.png',
            )
          ],
        ),
      ),
    ));
  }
}
