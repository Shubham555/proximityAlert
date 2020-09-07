import 'package:covidScanner/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:covidScanner/models/location_history.dart';
import 'package:covidScanner/models/my_card.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeline_tile/timeline_tile.dart';

List l;

class HistoryScreen extends StatefulWidget {
  static const routeName = "/HistoryScreen";

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int first = 2;

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
                "History",
                style: kScreenTitle,
                textAlign: TextAlign.start,
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

      return Container(
          height: MediaQuery.of(context).size.height * 0.81,
          child: _buildList(context, snapshot.data.docs));
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  l = snapshot;
  return ListView.builder(
      itemCount: snapshot.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      itemBuilder: (context, index) =>
          _buildListItem(context, index, snapshot[index]));
}

Widget _buildListItem(BuildContext context, int index, DocumentSnapshot data) {
  final locationHistory = LocationHistory.fromSnapshot(data);
  return TimelineTile(
    isFirst: index == 0,
    isLast: index == l.length - 1,
    topLineStyle: LineStyle(width: 1),
    indicatorStyle: IndicatorStyle(
        width: 18,
        drawGap: true,
        indicator: Container(
          decoration: BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
              shape: BoxShape.circle),
        )),
    rightChild: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: MyCard(
        first: index == 0,
        location: locationHistory,
      ),
    ),
  );
}
