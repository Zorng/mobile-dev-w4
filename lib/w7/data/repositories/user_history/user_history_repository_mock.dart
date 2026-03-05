import 'package:mobile_dev_w4/w7/data/repositories/user_history/user_history_repository.dart';
import 'package:mobile_dev_w4/w7/model/songs/song.dart';

class UserHistoryRepositoryMock implements UserHistoryRepository {
  final List<Song> _recentSongs = [];
  final List<Song> _recommendedSongs = [];

  @override
  List<Song> fetchRecentSongs() {
    return _recentSongs;
  }

  @override
  void updateRecentSongs(Song newSong) {
    _recentSongs.insert(0, newSong);
  }

  @override
  List<Song> fetchRecommendedSongs() {
    return _recommendedSongs;
  }
}
