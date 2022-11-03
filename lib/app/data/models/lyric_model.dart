import 'dart:convert';

LyricModel lyricModelFromJson(String str) =>
    LyricModel.fromJson(json.decode(str));

String lyricModelToJson(LyricModel data) => json.encode(data.toJson());

class LyricModel {
  LyricModel({
    required this.message,
  });

  final Message message;

  factory LyricModel.fromJson(Map<String, dynamic> json) => LyricModel(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Message {
  Message({
    required this.header,
    required this.body,
  });

  final Header header;
  final Body body;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        header: Header.fromJson(json["header"]),
        body: Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "header": header.toJson(),
        "body": body.toJson(),
      };
}

class Body {
  Body({
    required this.lyrics,
  });

  final Lyrics lyrics;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        lyrics: Lyrics.fromJson(json["lyrics"]),
      );

  Map<String, dynamic> toJson() => {
        "lyrics": lyrics.toJson(),
      };
}

class Lyrics {
  Lyrics({
    required this.lyricsId,
    required this.lyricsBody,
  });

  final int lyricsId;
  final String lyricsBody;

  factory Lyrics.fromJson(Map<String, dynamic> json) => Lyrics(
        lyricsId: json["lyrics_id"],
        lyricsBody: json["lyrics_body"],
      );

  Map<String, dynamic> toJson() => {
        "lyrics_id": lyricsId,
        "lyrics_body": lyricsBody,
      };
}

class Header {
  Header({
    required this.statusCode,
  });

  final int statusCode;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
      };
}
