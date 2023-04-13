class Region {
  final double latitude;
  final double longitude;
  final double radius;
  final String name;

  Region(this.latitude, this.longitude, this.radius, this.name);

  Region.fromJson(Map<String, Object?> json)
      : this(json["latitude"] as double, json["longitude"] as double,
            json["radius"] as double, json["name"] as String);

  Map<String, Object?> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "radius": radius,
      "name": name
    };
  }
}
