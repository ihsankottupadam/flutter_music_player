import 'package:flutter/material.dart';

class MyPopupMenu extends StatelessWidget {
  const MyPopupMenu(
      {Key? key, required this.items, required this.onItemSelected})
      : super(key: key);
  final List<MyPopupItem> items;
  final Function(dynamic) onItemSelected;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) => onItemSelected.call(value),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.grey.shade900.withOpacity(.9),
      elevation: 1,
      //position: PopupMenuPosition.under,
      itemBuilder: (context) {
        return items
            .map((item) => PopupMenuItem(
                value: item.id,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      item.icon,
                    ),
                    const SizedBox(width: 10),
                    Text(item.title)
                  ],
                )))
            .toList();
      },
    );
  }
}

class MyPopupItem {
  MyPopupItem({required this.id, required this.title, required this.icon});
  final int id;
  final String title;
  final IconData icon;
}
