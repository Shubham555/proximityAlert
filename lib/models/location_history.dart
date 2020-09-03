import 'dart:convert';
import 'package:covidScanner/services/authservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LocationHistory extends ChangeNotifier {
  LocationHistory({
    this.location,
    this.sublocation,
    this.time,
  });
  final String location;
  final String sublocation;

  final String time;
  List<LocationHistory> locationHistory = [];

  Future<dynamic> getLocationHistory(String uid) async {
    const String url =
        "https://noname-23981.firebaseio.com/location-history.json";
    var response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    locationHistory = [];
    extractedData.forEach((key, value) {
      if (value['uid'] == uid) {
        locationHistory.add(
          LocationHistory(
            location: value['location'],
            sublocation: value['sublocation'],
            time: value['dateTime'],
          ),
        );
      }
    });
    notifyListeners();

    return 1;
  }
}
