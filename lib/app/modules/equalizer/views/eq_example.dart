import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:get/get.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';

class Eqex extends StatefulWidget {
  const Eqex({Key? key}) : super(key: key);

  @override
  State<Eqex> createState() => _EqexState();
}

class _EqexState extends State<Eqex> {
  bool enableCustomEQ = false;

  @override
  void initState() {
    super.initState();
    EqualizerFlutter.init(Get.find<PlayerController>().getSessionId());
  }

  // @override
  // void dispose() {
  //   EqualizerFlutter.release();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equalizer example'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10.0),
          Center(
            child: Builder(
              builder: (context) {
                return TextButton.icon(
                  icon: Icon(Icons.equalizer),
                  label: Text('Open device equalizer'),
                  onPressed: () async {
                    try {
                      await EqualizerFlutter.open(
                          Get.find<PlayerController>().getSessionId());
                    } on PlatformException catch (e) {
                      final snackBar = SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text('${e.message}\n${e.details}'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            color: Colors.grey.withOpacity(0.1),
            child: SwitchListTile(
              title: Text('Custom Equalizer'),
              value: enableCustomEQ,
              onChanged: (value) {
                EqualizerFlutter.setEnabled(value);
                setState(() {
                  enableCustomEQ = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FutureBuilder<List<int>>(
            future: EqualizerFlutter.getBandLevelRange(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? CustomEQ(enableCustomEQ, snapshot.data!)
                  : CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}

class CustomEQ extends StatefulWidget {
  const CustomEQ(this.enabled, this.bandLevelRange, {super.key});

  final bool enabled;
  final List<int> bandLevelRange;

  @override
  State<CustomEQ> createState() => _CustomEQState();
}

class _CustomEQState extends State<CustomEQ> {
  late double min, max;
  String? _selectedValue;
  late Future<List<String>> fetchPresets;

  @override
  void initState() {
    super.initState();
    min = widget.bandLevelRange[0].toDouble();
    max = widget.bandLevelRange[1].toDouble();
    fetchPresets = EqualizerFlutter.getPresetNames();
  }

  @override
  Widget build(BuildContext context) {
    int bandId = 0;

    return FutureBuilder<List<int>>(
      future: EqualizerFlutter.getCenterBandFreqs(),
      builder: (context, snapshot) {
        int index = -1;
        return snapshot.connectionState == ConnectionState.done
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data!.map((freq) {
                      index++;
                      return _buildSliderBand(freq, bandId, index);
                    }).toList(),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: _buildPresets(),
                  ),
                ],
              )
            : const CircularProgressIndicator();
      },
    );
  }

  Widget _buildSliderBand(int freq, int bandId, int index) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            child: FutureBuilder<int>(
              future: EqualizerFlutter.getBandLevel(index),
              builder: (context, snapshot) {
                var data = snapshot.data?.toDouble() ?? 0.0;
                return RotatedBox(
                  quarterTurns: -1,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 1, trackShape: SliderCustomTrackShape()),
                    child: Center(
                      child: Slider(
                        min: min,
                        max: max,
                        value: data,
                        onChanged: (lowerValue) {
                          EqualizerFlutter.setBandLevel(
                              index, lowerValue.toInt());
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Text('${freq ~/ 1000} Hz'),
        ],
      ),
    );
  }

  Widget _buildPresets() {
    return FutureBuilder<List<String>>(
      future: fetchPresets,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final presets = snapshot.data;
          if (presets!.isEmpty) return const Text('No presets available!');
          return DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: 'Available Presets',
              border: OutlineInputBorder(),
            ),
            value: _selectedValue,
            onChanged: widget.enabled
                ? (String? value) {
                    EqualizerFlutter.setPreset(value!);
                    setState(() {
                      _selectedValue = value;
                    });
                  }
                : null,
            items: presets.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class SliderCustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = (parentBox.size.height) / 2;
    const double trackWidth = 230;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight!);
  }
}
