import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';

class MyCard extends StatelessWidget {
  MyCard({this.title, this.subTitle, this.time, this.first});
  String title;
  String subTitle;
  String time;
  bool first = false;
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
                title,
                textAlign: TextAlign.left,
                style: first
                    ? kHistoryTitle.copyWith(color: Colors.white)
                    : kHistoryTitle,
              ),
              Text(
                subTitle,
                style: first
                    ? kHistorySubtitle.copyWith(color: Colors.white)
                    : kHistorySubtitle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    time,
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
