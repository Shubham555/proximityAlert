import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'location_history.dart';

class MyCard extends StatelessWidget {
  MyCard({this.loc, this.first});
  LocationHistory loc;
  bool first;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Card(
        margin: EdgeInsets.only(bottom: 15),
        color: first ? kPrimaryColor : kTextFieldBgColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 8, 17, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.location != null ? loc.location : " ",
                textAlign: TextAlign.left,
                style: first
                    ? kHistoryTitle.copyWith(color: Colors.white)
                    : kHistoryTitle,
              ),
              Text(
                loc.sublocation != null ? loc.sublocation : " ",
                style: first
                    ? kHistorySubtitle.copyWith(color: Colors.white)
                    : kHistorySubtitle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    loc.time != null ? loc.time : " ",
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
    );
  }
}
