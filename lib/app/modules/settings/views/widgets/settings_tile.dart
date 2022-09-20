import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? description;
  final VoidCallback? onTap;

  const SettingsTile(
      {Key? key, required this.title, this.description, this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(title),
      subtitle: description != null ? Text(description ?? '') : null,
    );
  }
}
