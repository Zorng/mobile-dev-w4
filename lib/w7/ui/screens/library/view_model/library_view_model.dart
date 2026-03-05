import 'package:flutter/widgets.dart';
import 'package:mobile_dev_w4/w7/data/repositories/songs/song_repository.dart';
import 'package:mobile_dev_w4/w7/data/repositories/user_history/user_history_repository.dart';
import 'package:mobile_dev_w4/w7/model/songs/song.dart';
import 'package:mobile_dev_w4/w7/ui/states/player_state.dart';

class LibraryViewModel with ChangeNotifier {
  // 1- Read the globbal song repository
  SongRepository songRepository;
  List<Song> _songs = [];
  bool isLoading = false;
  UserHistoryRepository userHistoryRepository;

  // 3 - Watch the globbal player state
  PlayerState playerState;

  LibraryViewModel({
    required this.userHistoryRepository,
    required this.songRepository,
    required this.playerState,
  }) {
    load();
  }

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    _songs = songRepository.fetchSongs();
    isLoading = false;
    notifyListeners();
  }

  List<Song> get songs => _songs;

  void play(Song song) {
    playerState.start(song);
    userHistoryRepository.updateRecentSongs(song);
  }

  void stop() {
    playerState.stop();
  }
}
