import 'package:cloud_firestore/cloud_firestore.dart';

class LocationHistory {
  final String location;
  final String sublocation;
  final DocumentReference reference;
  final String time;
  List<LocationHistory> locationHistory = [];

  LocationHistory.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['location'] != null),
        assert(map['sublocation'] != null),
        assert(map['dateTime'] != null),
        location = map['location'],
        sublocation = map['sublocation'],
        time = map['dateTime'];

  LocationHistory.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
