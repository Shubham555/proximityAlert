import 'package:covidScanner/screens/login_screen.dart';
import 'package:covidScanner/services/authservice.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/bg_clipper.dart';
import 'package:covidScanner/themes/button_style.dart';
import 'package:provider/provider.dart';

class OnBoardingScreenDark extends StatelessWidget {
  static const routeName = "/OnBoardingScreenDark";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(30, height * 0.03, 30, height * 0.078),
                child: Text(
                  "Proximity Alert",
                  style: kRegisterTitle,
                  textAlign: TextAlign.left,
                ),
              ),
              ClipPath(
                child: Container(
                  child: Image.asset(
                    'assets/images/get-started.png',
                    height: height * 0.4,
                  ),
                  height: height * 0.45,
                  color: kCurveBgColor,
                ),
                clipper: DoubleClipper(),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.08),
                child: Center(
                  child: Text(
                    "Join us to make your health\nour priority",
                    style: kguideText.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.fromLTRB(30, height * 0.04, 30, height * 0.03),
                child: Center(
                  child: ButtonStyle(
                      text: 'Get Started',
                      goto: () {
                        Provider.of<AuthService>(context).signOut();
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
