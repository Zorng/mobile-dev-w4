import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_dev_w4/w10/network/network.dart';

import '../../../model/artist/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  final Uri artistsUri = Network.baseUri.replace(path: '/artists.json');

  List<Artist>? _cachedArtists;

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Artist> result = [];
      for (final entry in songJson.entries) {
        result.add(ArtistDto.fromJson(entry.key, entry.value));
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<List<Artist>> getArtists({bool forceFetch = false}) async {
    if (_cachedArtists != null && forceFetch != true) {
      print('get artist from cached');
      return _cachedArtists!;
    }

    final artists = await fetchArtists();

    _cachedArtists = artists;
    print("get artists from api");
    return artists;
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {}
}
