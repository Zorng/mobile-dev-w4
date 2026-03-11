import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w8/model/songs/song.dart';
import 'package:mobile_dev_w4/w8/ui/utils/async_value.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();
    AsyncValue<List<Song>> songAsyncValue = mv.songValue;

    Widget content;

    switch (mv.songValue.state) {
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Text("Error");
        break;
      case AsyncValueState.success:
        content = Expanded(
          child: ListView.builder(
            itemCount: songAsyncValue.data!.length,
            itemBuilder: (context, index) => SongTile(
              song: songAsyncValue.data![index],
              isPlaying: mv.isSongPlaying(songAsyncValue.data![index]),
              onTap: () {
                mv.start(songAsyncValue.data![index]);
              },
            ),
          ),
        );
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          SizedBox(height: 50),
          content
        ],
      ),
    );
  }
}
