import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w10/model/artist/artist.dart';
import 'package:mobile_dev_w4/w10/model/comment/comment.dart';
import 'package:mobile_dev_w4/w10/ui/screens/artists/view_model/artist_detail_viewmodel.dart';
import 'package:mobile_dev_w4/w10/ui/screens/artists/view_model/artist_item_data.dart';
import 'package:mobile_dev_w4/w10/ui/screens/artists/widgets/comment_form.dart';
import 'package:mobile_dev_w4/w10/ui/screens/artists/widgets/comment_tile.dart';
import 'package:mobile_dev_w4/w10/ui/screens/library/view_model/library_item_data.dart';
import 'package:mobile_dev_w4/w10/ui/screens/library/widgets/library_item_tile.dart';
import 'package:mobile_dev_w4/w10/ui/states/settings_state.dart';
import 'package:mobile_dev_w4/w10/ui/utils/async_value.dart';
import 'package:mobile_dev_w4/w8/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class ArtistDetailContent extends StatelessWidget {
  final Artist artist;
  const ArtistDetailContent({required this.artist, super.key});

  @override
  Widget build(BuildContext context) {
    AppSettingsState settingsState = context.watch<AppSettingsState>();
    ArtistDetailViewmodel vm = context.watch<ArtistDetailViewmodel>();
    AsyncValue<ArtistItemData> asyncValue = vm.data;

    Widget content;

    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error!}',
            style: TextStyle(color: Colors.red),
          ),
        );

      case AsyncValueState.success:
        ArtistItemData artistItemData = asyncValue.data!;
        content = Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Comments (${artistItemData.comments.length})"),
                FilledButton(
                  onPressed: () async {
                    final String? commentContent =
                        await showModalBottomSheet<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return CommentForm();
                          },
                        );
                    print(commentContent);
                    if (commentContent != null) {
                      return vm.addComment(
                        Comment(
                          id: 'id',
                          artistId: artist.id,
                          content: commentContent,
                        ),
                      );
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: settingsState.theme.color,
                  ),
                  child: const Text("Add Comment"),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: artistItemData.comments.length,
                itemBuilder: (context, index) {
                  return CommentTile(comment: artistItemData.comments[index]);
                },
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Songs (${artistItemData.songs.length})"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: artistItemData.songs.length,
                itemBuilder: (context, index) => LibraryItemTile(
                  data: LibraryItemData(
                    song: artistItemData.songs[index],
                    artist: artist,
                  ),
                  isPlaying: vm.isSongPlaying(artistItemData.songs[index]),
                  onTap: () {
                    vm.start(artistItemData.songs[index]);
                  },
                  onLike: () {
                    vm.likeSong(artistItemData.songs[index]);
                  },
                ),
              ),
            ),
          ],
        );
    }

    return Scaffold(
      backgroundColor: settingsState.theme.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(artist.imageUrl.toString()),
            ),
            const SizedBox(width: 8),
            Text(artist.name, style: AppTextStyles.heading),
            const SizedBox(width: 8),
            IconButton(onPressed: vm.refresh, icon: Icon(Icons.refresh)),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(padding: const EdgeInsetsGeometry.all(20), child: content),
    );
  }
}
