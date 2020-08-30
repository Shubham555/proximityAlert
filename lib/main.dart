import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/opt_verification_screen.dart';
import 'screens/identification_screen.dart';
import 'screens/home_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/history_screen.dart';
import 'models/bottom_navigation_bar.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
        'HomeScreen': (context) => HomeScreen(),
        'BottomNavBar': (context) => MyBottomNavBar(),
        NotificationScreen().id: (context) => NotificationScreen(),
        'HistoryScreen': (context) => HistoryScreen(),
      },
    );
  }
}
