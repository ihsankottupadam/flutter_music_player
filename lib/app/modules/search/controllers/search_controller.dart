import 'package:get/get.dart';
import 'package:music_player/app/modules/library/controllers/library_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchController extends GetxController {
  LibraryController libraryController = Get.find();
  List<SongModel> allSongs = [];
  RxList results = [].obs;

  @override
  void onInit() {
    allSongs = libraryController.songs;
    results.value = allSongs;
    super.onInit();
  }

  search(String query) {
    results.value = allSongs
        .where((song) => song.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
