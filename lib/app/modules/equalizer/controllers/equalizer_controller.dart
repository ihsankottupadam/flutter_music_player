import 'dart:developer';

import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:get/get.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';

class EqualizerController extends GetxController {
  RxBool enabled = false.obs;
  final PlayerController playerController = Get.find();
  int? currentSessionId;
  late double min;
  late double max;
  List<int>? bandFreqs;
  late List<RxInt> bandLevels;
  // late RxList<int> bandLev;
  List<String>? presets;
  String? selectedPresest;
  @override
  void onInit() {
    super.onInit();
    initEqualizer();
    listernAudioSessions();
  }

  Future<bool> initEqualizer() async {
    var audioSesssionId = playerController.getSessionId();
    currentSessionId = audioSesssionId;
    log(audioSesssionId.toString());
    if (audioSesssionId == null) return false;
    await EqualizerFlutter.init(audioSesssionId);
    return true;
  }

  setEnabled(bool enable) {
    EqualizerFlutter.setEnabled(enable);
    enabled.value = enable;
  }

  setBandLevel(int bandId, int level) {
    EqualizerFlutter.setBandLevel(bandId, level);
    bandLevels[bandId].value = level;
  }

  void setPreset(String? preset) async {
    if (presets == null) {
      return;
    }
    selectedPresest = preset;
    await EqualizerFlutter.setPreset(preset!);
    await loadVals();
    update();
  }

  loadView() async {
    var bandLevelRange = await EqualizerFlutter.getBandLevelRange();
    min = bandLevelRange[0].toDouble();
    max = bandLevelRange[1].toDouble();

    bandFreqs = await EqualizerFlutter.getCenterBandFreqs();
    if (bandFreqs == null) return;
    presets = await EqualizerFlutter.getPresetNames();
    // bandVals = List.filled(bandFreqs!.length, 15.obs);
    bandLevels = [];
    for (var i = 0; i < bandFreqs!.length; i++) {
      bandLevels.add(min.toInt().obs);
    }
    // List<int> vals = [];
    // for (var i = 0; i < bandFreqs!.length; i++) {
    //   vals.add(min.toInt());
    // }
    // bandLev = vals.obs;
    await loadVals();
    update();
  }

  loadVals() async {
    for (var i = 0; i < bandFreqs!.length; i++) {
      bandLevels[i].value = await EqualizerFlutter.getBandLevel(i);
    }
    // for (var i = 0; i < bandFreqs!.length; i++) {
    //   bandLev[i] = await EqualizerFlutter.getBandLevel(i);
    // }
  }

  listernAudioSessions() {
    Get.find<PlayerController>()
        .player
        .androidAudioSessionIdStream
        .listen((id) {
      //log('id changed $id');
      if (id == null && currentSessionId != null) {
        EqualizerFlutter.removeAudioSessionId(currentSessionId!);
        log('removed $currentSessionId from Equalizer');
      } else if (enabled.value == true) {
        initEqualizer();
        // EqualizerFlutter.setAudioSessionId(playerController.getSessionId());
        currentSessionId = id;
        log('added $currentSessionId to Equalizer');
      }
    });
  }

  openSysyemEqualizer(audioSessionId) {
    EqualizerFlutter.open(audioSessionId);
  }
}
