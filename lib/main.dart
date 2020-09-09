import 'package:covidScanner/services/authservice.dart';
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
        initialRoute: OnBoardingScreen.routeName,
        routes: {
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
