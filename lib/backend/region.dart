class Region {
  final double latitude;
  final double longitude;
  final double radius;

  Region(this.latitude, this.longitude, this.radius);

  Region.fromJson(Map<String, Object?> json)
      : this(json["latitude"] as double, json["longitude"] as double,
            json["radius"] as double);

  Map<String, Object?> toJson() {
    return {"latitude": latitude, "longitude": longitude, "radius": radius};
  }
}
