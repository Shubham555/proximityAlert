import 'package:covidScanner/screens/identification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:covidScanner/models/bottom_navigation_bar.dart';
import 'package:covidScanner/screens/onboarding_screen.dart';
import 'package:covidScanner/screens/login_screen.dart';

class AuthService with ChangeNotifier {
  String phoneNo;
  String verificationId;
  bool codeSent = false;
  var signInSuccess;
  //Handles Auth
  User user;
  StreamSubscription userAuthSub;

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
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verificationId) {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    signIn(authCreds);
  }
}
