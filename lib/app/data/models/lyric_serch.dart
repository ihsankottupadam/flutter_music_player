import 'dart:convert';

LyricSerch lyricSerchFromJson(String str) =>
    LyricSerch.fromJson(json.decode(str));

String lyricSerchToJson(LyricSerch data) => json.encode(data.toJson());

class LyricSerch {
  LyricSerch({
    required this.message,
  });

  final Message message;

  factory LyricSerch.fromJson(Map<String, dynamic> json) => LyricSerch(
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
    required this.trackList,
  });

  final List<TrackList> trackList;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        trackList: List<TrackList>.from(
            json["track_list"].map((x) => TrackList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "track_list": List<dynamic>.from(trackList.map((x) => x.toJson())),
      };
}

class TrackList {
  TrackList({
    required this.track,
  });

  final Track track;

  factory TrackList.fromJson(Map<String, dynamic> json) => TrackList(
        track: Track.fromJson(json["track"]),
      );

  Map<String, dynamic> toJson() => {
        "track": track.toJson(),
      };
}

class Track {
  Track({
    required this.trackId,
    required this.trackName,
    required this.hasLyrics,
    required this.numFavourite,
    required this.albumId,
    required this.albumName,
    required this.artistId,
    required this.artistName,
  });

  final int trackId;
  final String trackName;
  final int hasLyrics;
  final int numFavourite;
  final int albumId;
  final String albumName;
  final int artistId;
  final String artistName;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        trackId: json["track_id"],
        trackName: json["track_name"],
        hasLyrics: json["has_lyrics"],
        numFavourite: json["num_favourite"],
        albumId: json["album_id"],
        albumName: json["album_name"],
        artistId: json["artist_id"],
        artistName: json["artist_name"],
      );

  Map<String, dynamic> toJson() => {
        "track_id": trackId,
        "track_name": trackName,
        "has_lyrics": hasLyrics,
        "num_favourite": numFavourite,
        "album_id": albumId,
        "album_name": albumName,
        "artist_id": artistId,
        "artist_name": artistName,
      };
}

class Header {
  Header({
    required this.statusCode,
    required this.available,
  });

  final int statusCode;
  final int available;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        statusCode: json["status_code"],
        available: json["available"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "available": available,
      };
}
