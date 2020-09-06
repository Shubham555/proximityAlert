import 'package:covidScanner/models/location_history.dart';
import 'package:covidScanner/screens/onboarding_dark.dart';
import 'package:covidScanner/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (context) => AuthService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnBoardingScreen(),
        routes: {
          OnBoardingScreenDark.routeName: (context) => OnBoardingScreenDark(),
          OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          OtpVerification.routeName: (context) => OtpVerification(),
          IdentificationScreen.routeName: (context) => IdentificationScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          MyBottomNavBar.routeName: (context) => MyBottomNavBar(),
          NotificationScreen.routeName: (context) => NotificationScreen(),
          HistoryScreen.routeName: (context) => HistoryScreen(),
        },
      ),
    );
  }
}
