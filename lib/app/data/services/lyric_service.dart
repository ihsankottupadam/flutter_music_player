import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:music_player/app/data/models/lyric_model.dart';

import 'package:music_player/app/data/models/lyric_serch.dart';
import 'package:music_player/core/values/api_key.dart';

class LyricService {
  late Dio dio;
  LyricService() {
    dio = Dio();
    dio.options.baseUrl = 'http://api.musixmatch.com/ws/1.1/';
  }
  Future<String?> searchLyrics(String songTitle) async {
    int? trackId = await _getTrackId(songTitle);
    if (trackId == null) return null;
    log(trackId.toString());
    String? lyrics = await _getLyrics(trackId);
    return lyrics;
  }

  Future<int?> _getTrackId(String title) async {
    log('searching $title');
    try {
      final responce = await dio.get(
          'track.search?apikey=${ApiKey.musixmatchKey}&q_track=${simplyfy(title)}&f_has_lyrics=true&page_size=1');
      if (responce.statusCode == 200) {
        var serchRes = lyricSerchFromJson(responce.data).message;
        if (serchRes.header.statusCode != 200 ||
            serchRes.body.trackList.isEmpty) {
          log('No Result');
          return null;
        }
        var tracks = serchRes.body.trackList;
        return tracks[0].track.trackId;
      }
    } catch (e) {
      log('ON TRACKID$e');
    }
    return null;
  }

  Future<String?> _getLyrics(int trackId) async {
    try {
      final response = await dio.get(
          'track.lyrics.get?track_id=$trackId&apikey=${ApiKey.musixmatchKey}');
      if (response.statusCode == 200) {
        var res = lyricModelFromJson(response.data);
        String lyrics = res.message.body.lyrics.lyricsBody;
        return lyrics;
      }
    } catch (e) {
      log('ON LYRICS $e');
    }
    return null;
  }

  String simplyfy(String text) {
    var list = text.split(' ');
    int len = list.length > 3 ? 3 : list.length;
    return list.sublist(0, len).join(' ');
  }
}
