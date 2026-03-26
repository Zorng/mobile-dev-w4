    import '../../model/songs/song.dart';

class SongDto {
  static const String idKey = 'id';
  static const String titleKey = 'title';
  static const String artistIdKey = 'artistId';
  static const String imageUrlKey = 'imageUrl';
  static const String durationKey = 'duration';   // in ms

  static Song fromJson(String id ,Map<String, dynamic> json) {

    assert(json[titleKey] is String);
    assert(json[artistIdKey] is String);
    assert(json[imageUrlKey] is String);
    assert(json[durationKey] is int);

    return Song(
      id: id,
      title: json[titleKey],
      artistId: json[artistIdKey],
      imageUrl: Uri.parse(json[imageUrlKey]),
      duration: Duration(milliseconds: json[durationKey]),
    );
  }

  /// Convert Song to JSON
  Map<String, dynamic> toJson(Song song) {
    return {
      idKey: song.id,
      titleKey: song.title,
      artistIdKey: song.artistId,
      imageUrlKey: song.imageUrl.toString(),
      durationKey: song.duration.inMilliseconds,
    };
  }
}
