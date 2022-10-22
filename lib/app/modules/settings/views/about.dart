import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'widgets/settings_bg.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final s = math.min(size.width, size.height);
    final iconSize = s * .2;
    return SettingsBg(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Music Player',
                      style: TextStyle(
                          fontSize: s * 0.07,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xaaffffff))),
                  const SizedBox(height: 15),
                  Image.asset('assets/images/app_icon.png',
                      width: iconSize, height: iconSize),
                  const SizedBox(height: 15),
                  const Text('Version 1.0.2'),
                  const SizedBox(height: 15),
                  RichText(
                      text: TextSpan(
                          text: 'Developed by ',
                          style: TextStyle(fontSize: s * .043),
                          children: [
                        TextSpan(
                            text: 'Ihsan Kottupadam',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _openMyProfile),
                      ])),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () => _showLicense(context),
                  child: const Text('LICENSE')),
            )
          ],
        ),
      ),
    ));
  }

  _showLicense(context) {
    showLicensePage(
      context: context,
      applicationIcon:
          Image.asset('assets/images/app_icon.png', width: 60, height: 60),
      applicationVersion: 'Version 1.0.2',
    );
  }

  void _openMyProfile() async {
    if (!await launchUrl(
        Uri.parse('https://in.linkedin.com/in/ihsan-kottupadam'),
        mode: LaunchMode.externalApplication)) {
      log('failed to lauch url');
    }
  }
}
