import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:covidScanner/models/location_history.dart';
import 'package:covidScanner/models/my_card.dart';

class HistoryScreen extends StatelessWidget {
  static const routeName = "/HistoryScreen";
  @override
  Widget build(BuildContext context) {
    print(locationHistory.length);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "History",
                style: kScreenTitle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Today",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: "GoogleSans"),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Expanded(
                  child: ListView.builder(
                      itemCount: locationHistory.length,
                      itemBuilder: (context, index) {
                        return MyCard(
                          title: locationHistory[index]['location'],
                          subTitle: locationHistory[index]['address'],
                          time: locationHistory[index]['time'],
                          first: index == 0,
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
