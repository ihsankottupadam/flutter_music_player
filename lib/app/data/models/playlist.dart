import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'playlist.g.dart';

@HiveType(typeId: 0)
class Playlist extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<Map> songs;

  Playlist({required this.name, List<Map>? songs}) : songs = songs ?? [];

  get id => key;

  bool addSong(SongModel song) {
    if (contains(song)) {
      return false;
    }
    songs.add(song.getMap);
    save();
    return true;
  }

  deleteSong(SongModel song) {
    songs.removeWhere((item) => item['_id'] == song.id);
    save();
  }

  List<SongModel> getSongs() {
    return songs.map((info) => SongModel(info)).toList();
  }

  bool contains(SongModel song) {
    for (var item in songs) {
      if (item['_id'] == song.id) return true;
    }
    return false;
  }
}
