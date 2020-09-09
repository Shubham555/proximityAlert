import 'package:covidScanner/screens/identification_screen.dart';
import 'package:covidScanner/screens/opt_verification_screen.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/bg_clipper.dart';
import 'package:covidScanner/themes/button_style.dart';
import 'package:covidScanner/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covidScanner/models/alert_box.dart';

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              child: Container(
                height: height * 0.32,
                color: kCurveBgColor,
                padding: EdgeInsets.symmetric(horizontal: width * 0.04866),
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
              padding: EdgeInsets.all(height * 0.03),
              child: Text(
                "We'll send an OTP to\nyour mobile number for verification",
                textAlign: TextAlign.center,
                style: kguideText,
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: height * 0.02),
                width: width * 0.6,
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
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                margin:
                    EdgeInsets.fromLTRB(0, height * 0.02, 0, height * 0.045),
                child: MyButtonStyle(
                  text: 'Next',
                  goto: () {
                    phoneNo != null
                        ? verifyPhone(this.phoneNo)
                        : showAlertDialog(context, "Enter a phone number");
                  },
                )),
            Container(
              height: height * 0.275,
              child: Image.asset(
                'assets/images/otp-sent.png',
              ),
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

  validatePhoneNo(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
