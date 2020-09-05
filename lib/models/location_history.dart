import 'package:cloud_firestore/cloud_firestore.dart';

class LocationHistory {
  final String location;

  final DocumentReference reference;
  final DateTime time;
  List<LocationHistory> locationHistory = [];

  LocationHistory.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['location'] != null),
        assert(map['dateTime'] != null),
        location = map['location'],
        time = DateTime.fromMicrosecondsSinceEpoch(
            map['dateTime'].microsecondsSinceEpoch);

  LocationHistory.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
