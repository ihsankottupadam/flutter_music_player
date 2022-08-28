import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoritesController extends GetxController {
  final Box _box = Hive.box('Favorites');
  late List<SongModel> _favSongs;
  @override
  void onInit() {
    _loadFavSongs();
    super.onInit();
  }

  List<SongModel> get favSongs => _favSongs;

  addToFav(SongModel song) {
    Map info = song.getMap;
    info['date_modified'] = DateTime.now().millisecondsSinceEpoch;
    _box.put(song.id, song.getMap);
    _loadFavSongs();
    update();
  }

  removeFav(int id) {
    if (_box.containsKey(id)) _box.delete(id);
    _loadFavSongs();
    update();
  }

  bool isInFav(int id) => _box.containsKey(id);

  _loadFavSongs() async {
    _favSongs = [];
    for (Map info in _box.values) {
      _favSongs.add(SongModel(info));
    }
    _favSongs.sort(
      (a, b) => a.dateModified!.compareTo(b.dateModified!),
    );
  }
}
