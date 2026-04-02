import 'package:flutter/material.dart';

// import 'package:mobile_dev_w4/w10/data/repositories/artist/artist_repository.dart';
import 'package:mobile_dev_w4/w10/data/repositories/comment/comment_repository.dart';
import 'package:mobile_dev_w4/w10/data/repositories/songs/song_repository.dart';
import 'package:mobile_dev_w4/w10/model/artist/artist.dart';
import 'package:mobile_dev_w4/w10/model/comment/comment.dart';
import 'package:mobile_dev_w4/w10/ui/screens/artists/view_model/artist_item_data.dart';

import 'package:mobile_dev_w4/w10/ui/states/player_state.dart';
import 'package:mobile_dev_w4/w10/ui/utils/async_value.dart';
import 'package:mobile_dev_w4/w10/model/songs/song.dart';

class ArtistDetailViewmodel extends ChangeNotifier {
  final Artist artist;
  final PlayerState playerState;
  final SongRepository songRepository;
  //final ArtistRepository artistRepository;
  final CommentRepository commentRepository;

  AsyncValue<ArtistItemData> data = AsyncValue.loading();

  ArtistDetailViewmodel({
    required this.playerState,
    required this.songRepository,
    // required this.artistRepository,
    required this.commentRepository,
    required this.artist,
  }) {
    playerState.addListener(notifyListeners);
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() {
    fetchData();
  }

  void refresh() {
    fetchData(forceFetch: true);
  }

  void fetchData({bool forceFetch = false}) async {
    data = AsyncValue.loading();
    notifyListeners();
    try {
      List<Song> songs = await songRepository.fetchSongByArtistId(
        artist.id,
        forceFetch: forceFetch,
      );
      List<Comment> comments = await commentRepository.fetchCommentsByArtistId(
        artist.id,
        forceFetch: forceFetch,
      );

      data = AsyncValue.success(
        ArtistItemData(artist: artist, songs: songs, comments: comments),
      );
    } catch (e) {
      data = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void addComment(Comment comment) async {
    try {
      await commentRepository.postComment(comment);
      final comments = await commentRepository.fetchCommentsByArtistId(
        artist.id,
      );
      data = AsyncValue.success(data.data!.copyWith(comments: comments));
    } catch (e) {
      data = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void likeSong(Song song) async {
    try {
      await songRepository.incrementLike(song);
      final List<Song> songs = await songRepository.fetchSongByArtistId(
        artist.id,
      );
      data = AsyncValue.success(data.data!.copyWith(songs: songs));
    } catch (e) {
      data = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
