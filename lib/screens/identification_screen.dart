import 'dart:io';
import 'package:covidScanner/services/authservice.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:covidScanner/models/bottom_navigation_bar.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/bg_clipper.dart';
import 'package:covidScanner/themes/button_style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:covidScanner/models/alert_box.dart';

class IdentificationScreen extends StatefulWidget {
  static const routeName = "/IdentificationScreen";

  @override
  _IdentificationScreenState createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> {
  upal() {}

  StorageReference storageReference = FirebaseStorage.instance.ref();
  File _image;
  bool uploadStart = false;
  bool uploadSuccess = true;
  final picker = ImagePicker();

  Future getnUploadImage(String uid) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });

    StorageReference ref = storageReference.child("AadharCards/");

    //StorageUpload task is used to put the data you want in storage
    //Make sure to get the image first before calling this method otherwise _image will be null.

    StorageUploadTask storageUploadTask = ref.child(uid).putFile(_image);

    if (storageUploadTask.isSuccessful ||
        storageUploadTask.isComplete ||
        storageUploadTask.isCanceled) {
      final String url = await ref.getDownloadURL();
      print("The download URL is " + url);
    } else if (storageUploadTask.isInProgress) {
      storageUploadTask.events.listen((event) {
        double percentage = 100 *
            (event.snapshot.bytesTransferred.toDouble() /
                event.snapshot.totalByteCount.toDouble());
        print("THe percentage " + percentage.toString());
      });

      StorageTaskSnapshot storageTaskSnapshot =
          await storageUploadTask.onComplete;
      var downloadUrl1 =
          await storageTaskSnapshot.ref.getDownloadURL().then((value) {
        uploadSuccess = true;
      });

      print("Download URL " + downloadUrl1.toString());
    } else {
      print("ERROR in the image picker");
    }
  }

  bool isSuccess = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            ClipPath(
              child: Container(
                height: height * 0.28,
                color: kCurveBgColor,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Text(
                    "Your\nIdentification",
                    style: kRegisterTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              clipper: BottomClipper(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Click on Icon to Upload an image of your\nAadhar Card",
                style: kguideText,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height * 0.03),
                color: kTextFieldBgColor,
              ),
              height: height * 0.16,
              width: height * 0.16,
              child: MaterialButton(
                onPressed: () {
                  String uid = Provider.of<AuthService>(context).user.uid;
                  getnUploadImage(uid).then((value) {
                    isSuccess = true;
                    showAlertDialog(context, "Aadhar card uploaded");
                  });
                },
                child: Image.asset('assets/images/upload.png'),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                margin:
                    EdgeInsets.fromLTRB(0, height * 0.02, 0, height * 0.025),
                child: MyButtonStyle(
                  text: 'Continue',
                  goto: () {
                    isSuccess
                        ? Navigator.pushNamed(context, MyBottomNavBar.routeName)
                        : print("not success");
                  },
                )),
            Container(
              height: height * 0.262,
              child: Image.asset(
                'assets/images/adhar-card.png',
              ),
            )
          ],
        ),
      )),
    );
  }
}
