import 'package:covidScanner/models/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:covidScanner/screens/onboarding_screen.dart';

class AuthService with ChangeNotifier {
  String phoneNo;
  String verificationId;
  bool codeSent = false;
  bool isSuccess;
  User user;
  StreamSubscription userAuthSub;
  //Handles Auth

  AuthService() {
    userAuthSub = FirebaseAuth.instance.authStateChanges().listen((newUser) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $newUser');
      user = newUser;
      notifyListeners();
    }, onError: (e) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
    });
  }

  bool get isAuthenticated {
    return user != null;
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
    isSuccess = false;
    // addBoolToSPfalse();
  }

  //SignIn
  signIn(AuthCredential authCreds) async {
    try {
      var firebaseUser =
          await FirebaseAuth.instance.signInWithCredential(authCreds);
      print("Login success");
      isSuccess = true;
      // addBoolToSPtrue();
      print(firebaseUser.user);
    } catch (e) {
      print(e);
      isSuccess = false;
    }
    notifyListeners();
  }

  signInWithOTP(smsCode, verificationId) async {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        smsCode: smsCode, verificationId: verificationId);
    await signIn(authCreds);
    user != null ? MyBottomNavBar() : OnBoardingScreen();
  }
}

// addBoolToSPtrue() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setBool('boolValue', true);
// }

// addBoolToSPfalse() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setBool('boolValue', false);
// }
