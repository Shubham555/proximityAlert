import 'package:covidScanner/screens/identification_screen.dart';
import 'package:covidScanner/screens/opt_verification_screen.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/bg_clipper.dart';
import 'package:covidScanner/themes/button_style.dart';
import 'package:covidScanner/services/authservice.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNo;

  String verificationId;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    AuthService authProvider = Provider.of(context);
    double height = MediaQuery.of(context).size.height;
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
                child: TextFormField(
                  maxLength: 10,
                  decoration: InputDecoration(
                    prefixText: "+91",
                  ),
                  keyboardType: TextInputType.phone,
                  onChanged: (val) {
                    setState(() {
                      this.phoneNo = "+91" + val;
                    });
                  },
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                margin:
                    EdgeInsets.fromLTRB(0, height * 0.02, 0, height * 0.045),
                child: ButtonStyle(
                  text: 'Next',
                  goto: () {
                    authProvider.signOut();
                    verifyPhone(this.phoneNo);
                  },
                )),
            Image.asset(
              'assets/images/otp-sent.png',
            )
          ],
        ),
      ),
    ));
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
      Navigator.pushNamed(context, IdentificationScreen.routeName);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      verificationId = verId;
      // setState(() {
      codeSent = true;
      Navigator.pushNamed(context, OtpVerification.routeName,
          arguments: verificationId);
      // });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
