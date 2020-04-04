import 'dart:convert';

class LocationState {
  bool north;

  LocationState({this.north});

  factory LocationState.initial() => LocationState(north: true);

  @override
  operator ==(Object other) =>
  identical(this, other) ||
  other is LocationState && north == other.north;

  @override
  int get hashCode => north.hashCode;

  @override
  String toString() {
    return 'LocationState:{north: $north}';
  }

  factory LocationState.fromjson(Map<String, dynamic> json) =>
    LocationState(north: json['north']);

  dynamic toJson() => jsonEncode({'north': north});
}