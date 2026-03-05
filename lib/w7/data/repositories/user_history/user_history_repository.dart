import 'package:mobile_dev_w4/w7/model/songs/song.dart';

abstract class UserHistoryRepository {
  List<Song> fetchRecentSongs();
  List<Song> fetchRecommendedSongs();
  void updateRecentSongs(Song newSong);
}
