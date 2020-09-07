import 'dart:io';
import 'package:covidScanner/screens/onboarding_screen.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/button_style.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:covidScanner/services/authservice.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _configureFirebaseListners();
  }

  final FirebaseMessaging _fcm = FirebaseMessaging();

  _configureFirebaseListners() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("Message: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("Message: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("Message: $message");
      },
    );
  }

  var db = FirebaseFirestore.instance;

  Future scanQr(String uid) async {
    String fcmToken = await _fcm.getToken().then((value) {
      print("FCM:  $value");
      return value;
    });

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = db.collection('user').doc(uid);

      await tokens.set({
        'fcm': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
    String cameraScanResult = await scanner.scan();
    var now = DateTime.now();
    var locationRef =
        db.collection('user').doc(uid).collection('location-history');

    locationRef
        .add({'location': cameraScanResult, 'dateTime': now, 'docuid': uid});
  }

  @override
  Widget build(BuildContext context) {
    AuthService authProvider = Provider.of(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                "SCAN CODE",
                style: kScreenTitle,
              ),
              SizedBox(
                width: width * 0.14,
              ),
              Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                child: RawMaterialButton(
                  child: Image.asset(
                    'assets/images/power2.png',
                    color: Colors.black,
                  ),
                  onPressed: () {
                    AuthService().signOut();
                    Navigator.pushNamed(context, OnBoardingScreen.routeName);
                  },
                ),
              )
            ]),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(
                  width * 0.05, height * 0.15, width * 0.05, height * 0.08),
              height: height * 0.25,
              child: Image.asset('assets/images/scan.png'),
            ),
            Text(
              "Start Scanning",
              style: kRegisterTitle.copyWith(fontSize: 28),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              "Hold Top of your smartphone\nclose to the QR code",
              style: kguideText,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height * 0.08,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: MyButtonStyle(
                text: "Scan Now",
                goto: () => scanQr(authProvider.user.uid),
              ),
            )
          ],
        ),
      ),
    );
  }
}
