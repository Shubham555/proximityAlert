import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:covidScanner/models/location_history.dart';
import 'package:intl/intl.dart';

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
                Text("Proximity Alert",
                    textAlign: TextAlign.left,
                    style: first
                        ? kHistoryTitle.copyWith(
                            color: Colors.white,
                          )
                        : kHistoryTitle),
                Text(
                  "You might have encountered a Covid +ve person, consider a testing done.\nBe Safe!!",
                  style: first
                      ? kHistorySubtitle.copyWith(
                          color: Colors.white,
                        )
                      : kHistorySubtitle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat.yMMMd().format(location.time).toString(),
                      style: first
                          ? kHistorySubtitle.copyWith(
                              fontSize: 13, color: Colors.white)
                          : kHistorySubtitle.copyWith(
                              fontSize: 13, color: Colors.black),
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
