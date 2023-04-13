class Message {
  final String text;
  final double latitude;
  final double longitude;
  final String regionName;

  Message(this.latitude, this.longitude, this.text, this.regionName);

  Message.fromJson(Map<String, Object?> json)
      : this(json["latitude"] as double, json["longitude"] as double,
            json["text"] as String, json["regionName"] as String);

  Map<String, Object?> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "text": text,
      "regionName": regionName,
    };
  }
}
