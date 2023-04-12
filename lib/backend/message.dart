import 'region.dart';

class Message {
  final String author;
  final String text;
  final Region region;
  final String? media;

  Message(this.author, this.text, this.region, {this.media});

  Message.fromJson(Map<String, Object?> json)
      : this(
            json["author"] as String,
            json["text"] as String,
            Region(json["latitude"] as double, json["longitude"] as double,
                json["radius"] as double),
            media: json["media"] as String?);

  Map<String, Object?> toJson() {
    return {
      'author': author,
      'text': text,
      'latitude': region.latitude,
      'longitude': region.longitude,
      'radius': region.radius,
      'media': media
    };
  }
}
