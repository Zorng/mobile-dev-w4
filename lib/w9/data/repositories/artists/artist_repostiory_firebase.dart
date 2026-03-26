import 'dart:convert';
import 'package:mobile_dev_w4/w9/data/dtos/artist_dto.dart';
import 'package:mobile_dev_w4/w9/data/repositories/artists/artitst_repository.dart';
import 'package:mobile_dev_w4/w9/model/artists/artist.dart';
import 'package:mobile_dev_w4/w9/network/network.dart';
import 'package:http/http.dart' as http;

class ArtistRepostioryFirebase implements ArtitstRepository {
  final Uri artistUri = Network.baseUri.replace(path: '/artists.json');

  @override
  Future<List<Artist>> getAllArtist() async {
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      final List<Artist> result = [];

      Map<String, dynamic> artistsJson = json.decode(response.body);

      for (var iterable in artistsJson.entries) {
        String id = iterable.key;

        result.add(ArtistDto.fromJson(id, iterable.value));
      }

      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Artist?> getArtistById(String id) async {
    final http.Response response = await http.get(
      artistUri.replace(path: '/artists/$id.json'),
    );

    if (response.statusCode == 200) {
      final Artist? result;

      Map<String, dynamic> artistJson = json.decode(response.body);

      result = ArtistDto.fromJson(id, artistJson);

      return result;
    } else {
      throw Exception("artist with id: $id not found");
    }
  }
}
