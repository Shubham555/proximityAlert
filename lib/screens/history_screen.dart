import 'package:covidScanner/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:covidScanner/models/location_history.dart';
import 'package:covidScanner/models/my_card.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = "/HistoryScreen";

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<AuthService>(context).user.uid;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 800,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "History",
                style: kScreenTitle,
              ),
              SizedBox(
                height: 8,
              ),
              _buildBody(context, uid),
            ],
          ),
        ),
      ),
    );
  }
}

bool first = true;
Widget _buildBody(BuildContext context, String uid) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('location-history')
        .orderBy('dateTime', descending: true)
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();

      return _buildList(context, snapshot.data.docs);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    shrinkWrap: true,
    padding: const EdgeInsets.only(top: 20.0),
    children:
        snapshot.map((data) => _buildListItem(context, data))?.toList() ?? [],
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final locationHistory = LocationHistory.fromSnapshot(data);
  DateTime time = DateTime.fromMicrosecondsSinceEpoch(
      locationHistory.time.microsecondsSinceEpoch);
  return MyCard(
    first: time.difference(DateTime.now()).inDays == 0 ? true : false,
    location: locationHistory,
  );
}

Widget _locationList(BuildContext context, DocumentSnapshot data) {
  return Expanded(
    child: SizedBox(
      height: 400,
      child: Consumer<LocationHistory>(
        builder: (context, l, child) {
          return l.locationHistory.length == 0
              ? Center(
                  child: Text(
                    "Your History is Empty",
                    style: kHistoryTitle,
                  ),
                )
              : ListView.builder(
                  itemCount: l.locationHistory.length,
                  itemBuilder: (context, index) {
                    return MyCard(
                      location: l.locationHistory[index],
                      first: index == 0,
                    );
                  });
        },
      ),
    ),
  );
}
