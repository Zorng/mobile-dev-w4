import '../../../model/songs/song.dart';

abstract class SongRepository {
  Future<List<Song>> fetchSongs(); // fetch from api

  Future<List<Song>> getSongs({bool forceFetch}); // get from cached

  Future<Song?> fetchSongById(String id);
}
