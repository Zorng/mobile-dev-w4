import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w7/ui/common_widgets/song_tile.dart';
import 'package:mobile_dev_w4/w7/ui/screens/favorite/view_model/favorite_screen_view_model.dart';
import 'package:mobile_dev_w4/w7/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class FavoriteScreenContent extends StatelessWidget {
  const FavoriteScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteScreenViewModel vm = context.watch<FavoriteScreenViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16),
        Text("Favorite", style: AppTextStyles.heading),

        SizedBox(height: 50),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Recent Songs", style: AppTextStyles.body),
        ),
        vm.recentSongs.isEmpty
            ? Text("No recent songs")
            : Expanded(
                child: ListView.builder(
                  itemCount: vm.recentSongs.length,
                  itemBuilder: (context, index) => SongTile(
                    onTap: () {
                      vm.play(vm.recentSongs[index]);
                    },
                    onStop: () {
                      vm.stop();
                    },
                    song: vm.recentSongs[index],
                    isPlaying: vm.currentSong == vm.recentSongs[index],
                  ),
                ),
              ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Recent Songs", style: AppTextStyles.body),
        ),
        vm.recommendedSongs.isEmpty
            ? Text("No Recommendations")
            : Expanded(
                child: ListView.builder(
                  itemCount: vm.recommendedSongs.length,
                  itemBuilder: (context, index) => SongTile(
                    song: vm.recommendedSongs[index],
                    isPlaying: vm.currentSong == vm.recommendedSongs[index],
                    onTap: () {
                      vm.play(vm.recommendedSongs[index]);
                    },
                    onStop: () {
                      vm.stop();
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
