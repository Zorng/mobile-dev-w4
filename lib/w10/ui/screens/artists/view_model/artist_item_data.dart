import 'package:mobile_dev_w4/w10/model/artist/artist.dart';
import 'package:mobile_dev_w4/w10/model/comment/comment.dart';
import 'package:mobile_dev_w4/w10/model/songs/song.dart';

class ArtistItemData {
  final Artist artist;
  final List<Song> songs;
  final List<Comment> comments;

  ArtistItemData({
    required this.artist,
    required this.songs,
    required this.comments,
  });

  ArtistItemData copyWith({
    Artist? artist,
    List<Song>? songs,
    List<Comment>? comments,
  }) {
    return ArtistItemData(
      artist: artist ?? this.artist,
      songs: songs ?? this.songs,
      comments: comments?? this.comments,
    );
  }
}
