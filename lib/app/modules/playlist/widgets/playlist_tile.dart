import 'package:flutter/material.dart';
import 'package:music_player/app/widgets/dialog_confirm.dart';

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
                  MyPopupItem(id: 0, title: 'Rename', icon: Icons.edit),
                  MyPopupItem(
                      id: 1, title: 'Delete', icon: Icons.delete_rounded)
                ],
              onItemSelected: (id) {
                switch (id) {
                  case 0:
                    PlaylistHelper().renamePlaylist(context, playlist);
                    break;
                  case 1:
                    showDialog(
                        context: context,
                        builder: (context) => ConfirmDialog(
                              title: 'Confirm',
                              text: 'Are you sure to delete this playlist ?',
                              conformText: 'Delete',
                              onConfirm: () {
                                playlist.delete();
                                Navigator.pop(context);
                              },
                            ));

                    break;

                  default:
                }
              })
          : null,
    );
  }
}
