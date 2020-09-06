import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'location_history.dart';

class MyCard extends StatelessWidget {
  MyCard({this.location, this.first});
  final LocationHistory location;
  final bool first;
  @override
  Widget build(BuildContext context) {
    List<String> loc = location.location.split(',');

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
                  loc[0] != null ? loc[0] : " ",
                  textAlign: TextAlign.left,
                  style: first
                      ? kHistoryTitle.copyWith(color: Colors.white)
                      : kHistoryTitle,
                ),
                Text(
                  loc[1] != null ? loc[1] : " ",
                  style: first
                      ? kHistorySubtitle.copyWith(color: Colors.white)
                      : kHistorySubtitle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      location.time.toString() != null
                          ? location.time.toString().substring(0, 16)
                          : " ",
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
