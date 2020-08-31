import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:covidScanner/models/location_history.dart';

class HistoryScreen extends StatelessWidget {
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
                "History",
                style: kScreenTitle,
              ),
              Container(
                child: Expanded(
                  child: ListView.builder(
                      itemCount: locationHistory.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: kTextFieldBgColor,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(17, 5, 5, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  locationHistory[index]['location'],
                                  textAlign: TextAlign.left,
                                  style: kHistoryTitle,
                                ),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.ideographic,
                                  children: [
                                    Text(
                                      locationHistory[index]['address'],
                                      style: kHistorySubtitle,
                                    ),
                                    Text(locationHistory[index]['time']),
                                  ],
                                )
                              ],
                            ),
                          ),
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
