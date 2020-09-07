import 'package:covidScanner/models/bottom_navigation_bar.dart';
import 'package:covidScanner/screens/login_screen.dart';
import 'package:covidScanner/services/authservice.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/bg_clipper.dart';
import 'package:covidScanner/themes/button_style.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  static const routeName = "/OnBoardingScreen";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      30, height * 0.07, 30, height * 0.078),
                  child: Text(
                    "Proximity Alert",
                    style: kRegisterTitle.copyWith(fontSize: 45),
                  ),
                ),
                Container(
                    height: height * 0.4,
                    child: Image.asset('assets/images/logo2.png')),
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
                    child: MyButtonStyle(
                        text: 'Get Started',
                        goto: () {
                          Provider.of<AuthService>(context).user != null
                              ? Navigator.pushNamed(
                                  context, MyBottomNavBar.routeName)
                              : Navigator.pushNamed(
                                  context, LoginScreen.routeName);
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
