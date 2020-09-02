import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:covidScanner/models/notification_list.dart';
import 'package:covidScanner/models/my_card.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = "/NotificationScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notifications",
                style: kScreenTitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                child: ListView.builder(
                    itemCount: notificationHistory.length,
                    itemBuilder: (context, index) {
                      return MyCard(
                        title: "Proximity Alert",
                        subTitle:
                            "You might have encountered Covid +ve person at ${notificationHistory[index]['location']}. Consider a testing done",
                        time:
                            "${notificationHistory[index]['date']} ${notificationHistory[index]['time']}",
                        first: index == 0,
                      );
                    }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
