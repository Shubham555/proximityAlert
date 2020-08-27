import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/opt_verification_screen.dart';
import 'screens/identification_screen.dart';
import 'screens/home_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Scanner',
      initialRoute: '/',
      routes: {
        '/': (context) => OnBoardingScreen(),
        'LoginScreen': (context) => LoginScreen(),
        'OtpVerificationScreen': (context) => OtpVerification(),
        'IdentificationScreen': (context) => IdentificationScreen(),
      },
    );
  }
}
