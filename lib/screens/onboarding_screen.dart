import 'package:covidScanner/models/bottom_navigation_bar.dart';
import 'package:covidScanner/screens/login_screen.dart';
import 'package:covidScanner/services/authservice.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/button_style.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  static const routeName = "/OnBoardingScreen";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    width * 0.073, height * 0.07, width * 0.073, height * 0.1),
                child: Text(
                  "Proximity Alert",
                  textAlign: TextAlign.center,
                  style: kRegisterTitle.copyWith(fontSize: height * 0.053),
                ),
              ),
              Expanded(
                child: Container(child: Image.asset('assets/images/logo2.png')),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.07),
                child: Center(
                  child: Text(
                    "Join us to make your health\nour priority",
                    style: kguideText.copyWith(fontSize: width * 0.0584),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    width * 0.073, height * 0.04, width * 0.073, height * 0.05),
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
    );
  }
}
