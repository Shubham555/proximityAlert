import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'location_history.dart';
import 'package:intl/intl.dart';

class MyCard extends StatelessWidget {
  MyCard({this.location, this.first});
  final LocationHistory location;
  final bool first;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List<String> title = location.location.split(',');
    String subtitle = location.location.replaceFirst(title[0] + ",", "");
    subtitle = subtitle.replaceAll(",", "\n");
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        child: Card(
          color: first ? kPrimaryColor : kTextFieldBgColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(17, 8, 17, 8),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title[0] != null ? title[0] : " ",
                      textAlign: TextAlign.left,
                      style: first
                          ? kHistoryTitle.copyWith(color: Colors.white)
                          : kHistoryTitle,
                    ),
                    Text(
                      subtitle != null ? subtitle : " ",
                      style: first
                          ? kHistorySubtitle.copyWith(color: Colors.white)
                          : kHistorySubtitle,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  location.time.toString() != null
                      ? DateFormat.yMMMd().format(location.time).toString()
                      : " ",
                  style: first
                      ? kHistorySubtitle.copyWith(
                          fontSize: 13, color: Colors.white)
                      : kHistorySubtitle.copyWith(fontSize: 13),
                  textAlign: TextAlign.end,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
