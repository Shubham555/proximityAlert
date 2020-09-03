import 'package:covidScanner/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:covidScanner/models/location_history.dart';
import 'package:covidScanner/models/my_card.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = "/HistoryScreen";

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  var _isInit = true;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _isInit = true;
      AuthService authProvider = Provider.of(context);
      Provider.of<LocationHistory>(context)
          .getLocationHistory(authProvider.user.uid)
          .then((value) {
        setState(() {
          _isInit = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isInit
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
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
                    Expanded(
                      child: SizedBox(
                        height: 400,
                        child: Consumer<LocationHistory>(
                          builder: (context, l, child) {
                            return l.locationHistory.length == 0
                                ? Center(
                                    child: Text(
                                      "Your History is Empty",
                                      style: kHistoryTitle,
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: l.locationHistory.length,
                                    itemBuilder: (context, index) {
                                      return MyCard(
                                        loc: l.locationHistory[index],
                                        first: index == 0,
                                      );
                                    });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
