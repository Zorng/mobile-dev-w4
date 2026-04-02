import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_dev_w4/w10/network/network.dart';

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Network.baseUri.replace(path: '/songs.json');

  List<Song>? _cachedSongs;

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      _cachedSongs = result;
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<List<Song>> getSongs({bool forceFetch = false}) async {
    if (_cachedSongs != null && forceFetch != true) {
      print("get song from cached");
      return _cachedSongs!;
    }

    final songs = await fetchSongs();

    _cachedSongs = songs;
    print("get song from api");
    return songs;
  }

  @override
  Future<Song?> fetchSongById(String id) async {}

  @override
  Future<Song?> incrementLike(Song song) async {
    final int newLike = song.likes + 1;

    final http.Response response = await http.put(
      songsUri.replace(path: '/songs/${song.id}.json'),
      body: json.encode(SongDto.toJson(song.copyWith(likes: newLike))),
      //body: json.encode(song.copyWith(likes: newLike)),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> songJson = json.decode(response.body);

      Song result = SongDto.fromJson(song.id, songJson);
      int? index = _cachedSongs?.indexWhere((s) => s.id == song.id);
      _cachedSongs?.removeAt(index!);
      _cachedSongs?.insert(index!, result);

      return result;
    } else {
      throw Exception("cannot update");
    }
  }
}
