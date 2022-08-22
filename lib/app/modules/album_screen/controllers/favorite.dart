import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class OLdFavoritesController extends GetxController {
  late List<int> _favoriteIds;
  final List<SongModel> _favoriteSongs = [];
  Box box = Hive.box('Favorites');
  @override
  void onInit() {
    super.onInit();
    init();
  }

  init() {
    List<SongModel> allSongs = Get.find<PlayerController>().allSongs;
    // _favoriteSongs =
    //     allSongs.where((song) => _favoriteIds.contains(song.id)).toList();
    int loopCount = 0;
    favoriteSongs.clear();
    for (int id in _favoriteIds) {
      for (SongModel song in allSongs) {
        loopCount++;
        if (song.id == id) {
          favoriteSongs.add(song);
          return;
        }
      }
      print('Looped ...... $loopCount times');
    }

    // for(SongModel song in allSongs){
    //   for(int id in _favoriteIds){
    //     loopCount++;
    //      if (song.id == id) {
    //       favoriteSongs.add(song);
    //       return;
    //     }
    //   }
    //print('Looped ...... $loopCount times');
    // }
  }

  //List<int> get favoriteIds => _favoriteIds;
  List<SongModel> get favoriteSongs => _favoriteSongs;

  addSong(SongModel song) {
    final map = song.getMap;
  }

  removeSong(int songId) {
    update();
  }

  bool isInFavorite(int songId) {
    OnAudioQuery().queryWithFilters('', WithFiltersType.AUDIOS);

    if (_favoriteIds.contains(songId)) return true;
    return false;
  }
}
