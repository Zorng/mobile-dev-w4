import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w7/data/repositories/user_history/user_history_repository.dart';
import 'package:mobile_dev_w4/w7/model/songs/song.dart';
import 'package:mobile_dev_w4/w7/ui/states/player_state.dart';

class FavoriteScreenViewModel with ChangeNotifier {
  UserHistoryRepository repository;
  PlayerState playerState;
  bool isLoading = false;

  List<Song> _recentSongs = [];
  List<Song> _recommendedSongs = [];

  FavoriteScreenViewModel({
    required this.repository,
    required this.playerState,
  }) {
    load();
  }

  void load() {
    _recentSongs = repository.fetchRecentSongs();
  }

  List<Song> get recentSongs => _recentSongs;
  List<Song> get recommendedSongs => _recommendedSongs;

  void play(Song song) {
    playerState.start(song);
    notifyListeners();
    repository.updateRecentSongs(song);
  }

  void stop() {
    playerState.stop();
    notifyListeners();
  }

  Song? get currentSong => playerState.currentSong;
}
