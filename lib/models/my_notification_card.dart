import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:covidScanner/models/location_history.dart';

class MyNotificationCard extends StatelessWidget {
  MyNotificationCard({this.location, this.first});
  final LocationHistory location;

  final bool first;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        child: Card(
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
                      ? kHistoryTitle.copyWith(
                          color: Colors.white, fontSize: 17)
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
        ),
      ),
    );
  }
}
