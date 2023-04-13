class Message {
  final String text;
  final double latitude;
  final double longitude;
  final String region;

  Message(this.latitude, this.longitude, this.text, this.region);

  Message.fromJson(Map<String, Object?> json)
      : this(json["latitude"] as double, json["longitude"] as double,
            json["text"] as String, json["region"] as String);

  Map<String, Object?> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "text": text,
      "region": region,
    };
  }
}
