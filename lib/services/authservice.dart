import 'package:covidScanner/models/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class AuthService with ChangeNotifier {
  String phoneNo;
  String verificationId;
  bool codeSent = false;
  bool isSuccess = false;

  //Handles Auth
  User user;
  StreamSubscription userAuthSub;

  AuthService() {
    userAuthSub = FirebaseAuth.instance.authStateChanges().listen((newUser) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $newUser');
      user = newUser;
      // user!=null?MyBottomNavBar():
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
  signIn(AuthCredential authCreds) async {
    try {
      var firebaseUser =
          await FirebaseAuth.instance.signInWithCredential(authCreds);
      print("Login success");
      isSuccess = true;
      print(firebaseUser.user);
    } catch (e) {
      print("Login not successful");
      isSuccess = false;
    }
    notifyListeners();
  }

  signInWithOTP(smsCode, verificationId) {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        smsCode: smsCode, verificationId: verificationId);
    signIn(authCreds);
  }
}
