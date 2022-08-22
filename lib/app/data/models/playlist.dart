import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlist extends HiveObject {
  Playlist({required this.name, required this.songs});
  String name;
  List<SongModel> songs;
}
