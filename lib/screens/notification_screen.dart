import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:provider/provider.dart';
import 'package:covidScanner/models/my_notification_card.dart';
import 'package:covidScanner/services/authservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidScanner/models/location_history.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = "/NotificationScreen";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String uid = Provider.of<AuthService>(context).user.uid;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.only(top: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notifications",
                style: kScreenTitle,
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 10,
              ),
              _buildBody(context, uid)
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildBody(BuildContext context, String uid) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('infected-locations')
        .orderBy('dateTime')
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();

      return _buildList(context, snapshot.data.docs);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView.builder(
      itemCount: snapshot.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      itemBuilder: (context, index) =>
          _buildListItem(context, index, snapshot[index]));
}

Widget _buildListItem(BuildContext context, int index, DocumentSnapshot data) {
  final locationHistory = LocationHistory.fromSnapshot(data);

  return MyNotificationCard(
    first: index == 0,
    location: locationHistory,
  );
}
