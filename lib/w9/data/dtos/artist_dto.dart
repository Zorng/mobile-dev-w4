import 'package:mobile_dev_w4/w9/model/artists/artist.dart';

class ArtistDto {
  static const String idKey = "id";
  static const String nameKey = "name";
  static const String genreKey = "genre";
  static const String imageUrlKey = "imageUrl";

  static Artist fromJson(String id, Map<String, dynamic> json) {
    // assert(json[idKey] is String);
    assert(json[nameKey] is String);
    assert(json[genreKey] is String);
    assert(json[imageUrlKey] is String);

    return Artist(
      id: id,
      genre: Genre.values.firstWhere((g) => g.value.toLowerCase() == json[genreKey].toString().toLowerCase()),
      name: json[nameKey],
      imageUrl: Uri.parse(json[imageUrlKey]),
    );
  }

  static Map<String, dynamic> toJson(Artist artist) {
    return {
      artist.id: {
        nameKey: artist.name,
        genreKey: artist.genre,
        imageUrlKey: artist.imageUrl.toString(),
      },
    };
  }
}
