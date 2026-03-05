import 'package:mobile_dev_w4/w7/data/repositories/user_history/user_history_repository.dart';
import 'package:mobile_dev_w4/w7/model/songs/song.dart';

class UserHistoryRepositoryMock implements UserHistoryRepository {
  //recent songs should behave like a cache
  static const cacheSize = 5;
  final List<Song> _recentSongs = List.filled(cacheSize, Song.dummy(), growable: false);
  final List<Song> _recommendedSongs = [];

  @override
  List<Song> fetchRecentSongs() {
    return _recentSongs;
  }

  @override
  void updateRecentSongs(Song newSong) {
    int index = _recentSongs.indexOf(newSong);

    //handle new song not in recent list
    if (index == -1) {
      _recentSongs.insert(0, newSong);
    }

    //handle song already in recent list
    if (index != -1) {
      _recentSongs.removeAt(index);
      _recentSongs.insert(0, newSong);
    }

    //handle full cache
    if (_recentSongs.length == cacheSize) {
      _recentSongs.removeAt(_recentSongs.length);
      _recentSongs.insert(0, newSong);
    }
  }

  @override
  List<Song> fetchRecommendedSongs() {
    return _recommendedSongs;
  }
}
