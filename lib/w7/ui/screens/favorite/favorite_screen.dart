import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w7/data/repositories/user_history/user_history_repository.dart';
import 'package:mobile_dev_w4/w7/ui/screens/favorite/view_model/favorite_screen_view_model.dart';
import 'package:mobile_dev_w4/w7/ui/screens/favorite/widgets/favorite_screen_content.dart';
import 'package:provider/provider.dart';


import '../../states/player_state.dart';
import '../../states/settings_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    //   SongRepository songRepository = context.read<SongRepository>();
    //  // List<Song> songs = songRepository.fetchSongs();

    // 2- Read the globbal settings state
    AppSettingsState settingsState = context.read<AppSettingsState>();

    // 3 - Watch the globbal player state
   // PlayerState playerState = context.read<PlayerState>();

    // UserHistoryRepository userHistoryRepository = context
    //     .read<UserHistoryRepository>();

    return Container(
      color: settingsState.theme.backgroundColor,
      child: ChangeNotifierProvider(
        create: (context) => FavoriteScreenViewModel(
          repository: context.read<UserHistoryRepository>(),
          playerState: context.read<PlayerState>(),
        ),
        child: const FavoriteScreenContent()
      ),
    );
  }
}
