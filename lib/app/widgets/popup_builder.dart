import 'package:flutter/material.dart';

class PopupMenuBulder extends StatelessWidget {
  const PopupMenuBulder(
      {Key? key, required this.actions, required this.onSelected})
      : super(key: key);
  final List<String> actions;
  final PopupMenuItemSelected<String>? onSelected;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Colors.grey.shade900,
      elevation: 1,
      position: PopupMenuPosition.under,
      onSelected: (value) => print(value),
      itemBuilder: (context) {
        return actions
            .map((action) => PopupMenuItem(
                  value: action,
                  child: Text(action),
                ))
            .toList();
      },
    );
  }
}
