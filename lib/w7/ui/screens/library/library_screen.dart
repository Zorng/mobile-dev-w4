import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w7/data/repositories/songs/song_repository.dart';
import 'package:mobile_dev_w4/w7/ui/screens/library/view_model/library_view_model.dart';
import 'package:mobile_dev_w4/w7/ui/screens/library/widgets/library_content.dart';
import 'package:mobile_dev_w4/w7/ui/states/player_state.dart';
import 'package:provider/provider.dart';

import '../../states/settings_state.dart';


class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSettingsState settingsState = context.read<AppSettingsState>();
    
    return Container(
      color: settingsState.theme.backgroundColor,
      child: MultiProvider(
        providers: [
          //ChangeNotifierProvider(create: (context) => PlayerState()),
          ChangeNotifierProvider(
          create: (context) => LibraryViewModel(playerState: context.read<PlayerState>(), songRepository: context.read<SongRepository>()),)
        ],
        child: 
          LibraryContent()
        ),
    );
  }
}
