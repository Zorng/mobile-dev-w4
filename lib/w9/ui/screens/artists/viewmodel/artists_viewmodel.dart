import 'package:flutter/widgets.dart';
import 'package:mobile_dev_w4/w9/ui/utils/async_value.dart';
import 'package:mobile_dev_w4/w9/data/repositories/artists/artitst_repository.dart';
import 'package:mobile_dev_w4/w9/model/artists/artist.dart';

class ArtistsViewmodel extends ChangeNotifier {
  final ArtitstRepository repo;

  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();

  ArtistsViewmodel({required this.repo}) {
    _init();
  }

  void _init() async {
    fetchArtists();
  }

  void fetchArtists() async {
    artistsValue = AsyncValue.loading();
    notifyListeners();

    try {
      List<Artist> artists = await repo.getAllArtist();
      artistsValue = AsyncValue.success(artists);
    } catch (e) {
      artistsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
