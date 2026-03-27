import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w9/model/artists/artist.dart';
import 'package:provider/provider.dart';
import '../../../../model/songs/song.dart';
import '../../../theme/theme.dart';
import '../../../utils/async_value.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();

    AsyncValue<List<Song>> asyncValue = mv.songsValue;
    AsyncValue<List<Map<Song, Artist>>> asyncSongXInfo = mv.songsXInfo;

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
        //List<Song> songs = asyncValue.data!;
        List<Map<Song, Artist>>? songsXInfo = asyncSongXInfo.data
            ?.map((e) => e)
            .toList();

        content = ListView.builder(
          itemCount: songsXInfo!.length,
          itemBuilder: (context, index) {
            Map<Song, Artist> songXInfo = songsXInfo[index];
            return SongTile(
              artist: songXInfo.values.first,
              song: songXInfo.keys.first,
              isPlaying: mv.isSongPlaying(songXInfo.keys.first),
              onTap: () {
                mv.start(songXInfo.keys.first);
              },
            );
          },
        );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          SizedBox(height: 50),

          Expanded(child: content),
        ],
      ),
    );
  }
}
