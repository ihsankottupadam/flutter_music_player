import 'package:flutter/material.dart';

import '../../../data/models/playlist.dart';
import '../../../widgets/mypopupmenu.dart';
import '../controllers/playlist_helper.dart';

class PlaylistTile extends StatelessWidget {
  const PlaylistTile(
      {Key? key,
      required this.playlist,
      required this.onTap,
      this.showMenu = true})
      : super(key: key);
  final Playlist playlist;
  final VoidCallback onTap;
  final bool showMenu;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: const Icon(Icons.queue_music_rounded),
      title: Text(playlist.name),
      subtitle: Text('${playlist.songs.length} songs'),
      onTap: () {
        onTap();
      },
      trailing: showMenu
          ? MyPopupMenu(
              items: [
                  MyPopupItem(
                      id: 0, title: 'Delete', icon: Icons.delete_rounded),
                  MyPopupItem(id: 1, title: 'Rename', icon: Icons.edit)
                ],
              onItemSelected: (id) {
                switch (id) {
                  case 0:
                    playlist.delete();
                    break;
                  case 1:
                    PlaylistHelper().renamePlaylist(context, playlist);
                    break;
                  default:
                }
              })
          : null,
    );
  }
}
