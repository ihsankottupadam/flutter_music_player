import 'package:flutter/material.dart';

import '../../../data/models/playlist.dart';
import '../../../widgets/mypopupmenu.dart';
import '../controllers/playlist_helper.dart';

class PlaylistTile extends StatelessWidget {
  const PlaylistTile({Key? key, required this.playlist, required this.onTap})
      : super(key: key);
  final Playlist playlist;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: const Icon(Icons.featured_play_list),
      title: Text(playlist.name),
      subtitle: Text('${playlist.songs.length} songs'),
      onTap: () {
        onTap();
      },
      trailing: MyPopupMenu(
          items: [
            MyPopupItem(id: 0, title: 'Delete', icon: Icons.delete_rounded),
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
          }),
    );
  }
}