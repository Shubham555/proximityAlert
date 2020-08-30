import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "History",
                style: kScreenTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
