import 'package:covidScanner/screens/identification_screen.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/bg_clipper.dart';
import 'package:covidScanner/themes/button_style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:covidScanner/services/authservice.dart';
import 'package:provider/provider.dart';
import 'package:covidScanner/models/alert_box.dart';

class OtpVerification extends StatefulWidget {
  static const routeName = "/OtpVerificationScreen";

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  final myController = TextEditingController();
  String userOtp = "";
  @override
  Widget build(BuildContext context) {
    final String verId = ModalRoute.of(context).settings.arguments;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        key: key,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipPath(
                  child: Container(
                    height: height * 0.3,
                    color: kCurveBgColor,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Text(
                        "OTP\nVerification",
                        style: kRegisterTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  clipper: BottomClipper(),
                ),
                Container(
                  padding: EdgeInsets.all(height * 0.03558),
                  child: Text(
                    "Enter your OTP here",
                    style: kguideText,
                  ),
                ),

                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      textInputType: TextInputType.number,
                      controller: myController,
                      appContext: context,
                      onChanged: (String otp) {
                        setState(() {
                          userOtp = otp;
                        });
                      },
                      length: 6,
                      obsecureText: false,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v.length < 6) {
                          return "OTP too short!";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(20),
                          disabledColor: kTextFieldBgColor,
                          activeFillColor: Colors.amber),
                    ),
                  ),
                ),
                //Enter OTP here

                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  margin:
                      EdgeInsets.fromLTRB(0, height * 0.02, 0, height * 0.045),
                  child: MyButtonStyle(
                    text: 'Verify',
                    goto: () async {
                      print(userOtp);
                      await AuthService().signInWithOTP(userOtp, verId);
                      AuthService authProvider =
                          Provider.of<AuthService>(context, listen: true);
                      authProvider.isAuthenticated
                          ? Navigator.pushNamed(
                              context, IdentificationScreen.routeName)
                          : showAlertDialog(context, "Wrong OTP");
                    },
                  ),
                ),
                Container(
                  height: height * 0.32,
                  child: Image.asset(
                    'assets/images/otp.png',
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
