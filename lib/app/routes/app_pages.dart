import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/library/bindings/library_binding.dart';
import '../modules/library/views/library_view.dart';
import '../modules/player_screen/bindings/player_screen_binding.dart';
import '../modules/player_screen/views/player_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LIBRARY;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LIBRARY,
      page: () => const LibraryView(),
      binding: LibraryBinding(),
    ),
    GetPage(
      name: _Paths.PLAYER_SCREEN,
      page: () => PlayerScreenView(
        song: SongModel({}),
      ),
      binding: PlayerScreenBinding(),
    ),
  ];
}
