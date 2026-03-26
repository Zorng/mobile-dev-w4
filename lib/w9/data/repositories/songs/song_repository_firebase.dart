import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  static final Uri baseUri = Uri.https(
    'badwater-2102e-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
  static final Uri songsUri = baseUri.replace(path: '/songs.json');

  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      final List<Song> result = [];
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songsJson = json.decode(response.body);

      for (var iterable in songsJson.entries) {
        String id = iterable.key;

        // SongDto.fromJson(id, {
        //   SongDto.artistIdKey: iterable.value.artistId,
        //   SongDto.titleKey: iterable.value.title,
        //   SongDto.imageUrlKey: iterable.value.imageUrl,
        //   SongDto.durationKey: iterable.value.duration,
        // });

        result.add(SongDto.fromJson(id, iterable.value));
      }

      return result;

      //return songsJson.map((item) => SongDto.fromJson(item)).toList();
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
