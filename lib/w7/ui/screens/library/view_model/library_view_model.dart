import 'package:flutter/widgets.dart';
import 'package:mobile_dev_w4/w7/data/repositories/songs/song_repository.dart';
import 'package:mobile_dev_w4/w7/model/songs/song.dart';

class LibraryViewModel with ChangeNotifier {
  // 1- Read the globbal song repository
  SongRepository songRepository;
  List<Song> songs = [];
  bool isLoading = false;

  // 3 - Watch the globbal player state
  // PlayerState playerState;

  LibraryViewModel({required this.songRepository}) {
    load();
  }

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    songs = songRepository.fetchSongs();
    isLoading = false;
    notifyListeners();
  }
}
