import 'region.dart';
import 'dart:math';
import 'utils.dart';

class Message {
  final String text;
  final double latitude;
  final double longitude;
  late List<Region> inRegions;

  Message(this.latitude, this.longitude, this.text) {
    _initRegions(latitude, longitude);
  }

  Message.fromJson(Map<String, Object?> json)
      : this(json["latitude"] as double, json["longitude"] as double,
            json["text"] as String);

  Map<String, Object?> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "text": text,
      "inRegions": inRegions
    };
  }

  bool _inRegion(double latitude, double longitude, Region region) {
    double otherLatitude = region.latitude;
    double otherLongitude = region.longitude;
    double otherRadius = region.radius;
    double distance =
        _distance(latitude, longitude, otherLatitude, otherLongitude);

    return distance <= otherRadius;
  }

  double _distance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371.0; // in kilometers
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    double a = pow(sin(dLat / 2), 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;
    return distance;
  }

  double _toRadians(double degree) {
    return degree * pi / 180.0;
  }

  Future<void> _initRegions(double latitude, double longitude) async {
    List<Region> regions = await getAllRegions();
    List<Region> inRegions = [];
    for (Region other in regions) {
      if (_inRegion(latitude, longitude, other)) {
        inRegions.add(other);
      }
    }
    this.inRegions = inRegions;
  }
}
