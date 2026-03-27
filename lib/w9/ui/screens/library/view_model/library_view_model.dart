import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w9/data/repositories/artists/artitst_repository.dart';
import 'package:mobile_dev_w4/w9/model/artists/artist.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  final ArtitstRepository artitstRepository;

  AsyncValue<List<Song>> songsValue = AsyncValue.loading();

  AsyncValue<List<Map<Song, Artist>>> songsXInfo = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required this.artitstRepository,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Song> songs = await songRepository.fetchSongs();

      List<Artist> artists = await artitstRepository.getAllArtist();

      Map<String, Artist> idArtistMap = {for (var a in artists) a.id: a};

      List<Map<Song, Artist>> songsWithInfo = songs.map((song) {
        final artist = idArtistMap[song.artistId];
        return {
          song: artist!
        };
      }).toList();
      songsValue = AsyncValue.success(songs);
      songsXInfo = AsyncValue.success(songsWithInfo);
      //get song's extra info
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
