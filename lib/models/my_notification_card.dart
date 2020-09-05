import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:covidScanner/models/location_history.dart';

class MyNotificationCard extends StatelessWidget {
  MyNotificationCard({this.location, this.first});
  final LocationHistory location;

  final bool first;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      color: first ? kPrimaryColor : kTextFieldBgColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(17, 8, 17, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You might have been infected at ${location.location}",
              textAlign: TextAlign.left,
              style: first
                  ? kHistoryTitle.copyWith(color: Colors.white)
                  : kHistoryTitle,
            ),
            Text(
              "Consider getting yourself checked",
              style: first
                  ? kHistorySubtitle.copyWith(color: Colors.white)
                  : kHistorySubtitle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  location.time.toString().substring(0, 16),
                  style: first
                      ? kHistorySubtitle.copyWith(
                          fontSize: 13, color: Colors.white)
                      : kHistorySubtitle.copyWith(fontSize: 13),
                  textAlign: TextAlign.end,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
