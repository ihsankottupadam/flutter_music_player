import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';
import 'about.dart';
import 'widgets/settings_bg.dart';
import 'widgets/settings_tile.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SettingsBg(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SettingsTile(
                icon: Icons.feedback,
                title: 'Feedback',
                onTap: controller.feedback,
              ),
              SettingsTile(
                icon: Icons.info,
                title: 'About',
                onTap: () => Get.to(() => const AboutScreen()),
              ),
              SettingsTile(
                icon: Icons.history,
                title: 'Reset app',
                onTap: () => controller.reset(context),
              ),
              const SettingsTile(
                icon: Icons.memory,
                title: 'Version',
                description: 'V1.0.1',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
