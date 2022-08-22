import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/app/data/models/playlist.dart';

class PlaylistHelper {
  late List<Playlist> playlists;
  Box playlistbox = Hive.box('playlist');
  init() {}
}
