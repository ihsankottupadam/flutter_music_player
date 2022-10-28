import 'package:get/get.dart';

import '../modules/equalizer/bindings/equalizer_binding.dart';
import '../modules/equalizer/views/equalizer_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/library/bindings/library_binding.dart';
import '../modules/library/views/library_view.dart';
import '../modules/player_screen/bindings/player_screen_binding.dart';
import '../modules/player_screen/views/player_screen_view.dart';
import '../modules/queue/bindings/queue_binding.dart';
import '../modules/queue/views/queue_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

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
      page: () => const PlayerScreenView(),
      binding: PlayerScreenBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.QUEUE,
      page: () => QueueView(),
      binding: QueueBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.EQUALIZER,
      page: () => const EqualizerView(),
      binding: EqualizerBinding(),
    ),
  ];
}
