import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w7/ui/screens/library/view_model/library_view_model.dart';
import 'package:provider/provider.dart';

// import '../../../../data/repositories/songs/song_repository.dart';
// import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';
import '../../../theme/theme.dart';
import './song_tile.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    //SongRepository songRepository = context.read<SongRepository>();
    //List<Song> songs = songRepository.fetchSongs();

    // 3 - Watch the globbal player state
    PlayerState playerState = context.watch<PlayerState>();

    LibraryViewModel vm = context.watch<LibraryViewModel>();

    return vm.isLoading? Scaffold(body: CircularProgressIndicator(),) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),

          SizedBox(height: 50),

          Expanded(
            child: ListView.builder(
              itemCount: vm.songs.length,
              itemBuilder: (context, index) => SongTile(
                song: vm.songs[index],
                isPlaying: playerState.currentSong == vm.songs[index],
                onTap: () {
                  playerState.start(vm.songs[index]);
                },
              ),
            ),
          ),
        ],
    );
  }
}


