class Message {
  final String author;
  final String text;
  final double latitude;
  final double longitude;
  final String? media;

  Message(this.author, this.text, this.latitude, this.longitude, {this.media});

  Message.fromJson(Map<String, Object?> json)
      : this(json["author"] as String, json["text"] as String,
            json["latitude"] as double, json["longitude"] as double,
            media: json["media"] as String?);

  Map<String, Object?> toJson() {
    return {
      'author': author,
      'text': text,
      'latitude': latitude,
      'longitude': longitude,
      'media': media,
    };
  }
}
