import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w8/ui/utils/async_value.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  late AsyncValue<List<Song>> songValue;
  //List<Song>? _songs;

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);
    // init
    _init();
  }

  //List<Song> get songs => _songs == null ? [] : _songs!;

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    songValue = AsyncValue.loading();
    notifyListeners();
  
    // 1 - Fetch songs
    try {
      List<Song> songs = await songRepository.fetchSongs();
      songValue = AsyncValue.success(data: songs);
      //print("Song fetched");
    } catch (e) {
      songValue = AsyncValue.error(error: e);
      //print("Failed to fetch");
    }

    // 2 - notify listeners
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
