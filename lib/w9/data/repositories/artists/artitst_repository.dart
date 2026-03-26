import 'package:mobile_dev_w4/w9/model/artists/artist.dart';

abstract class ArtitstRepository {
  Future<List<Artist>> getAllArtist();
  Future<Artist?> getArtistById(String id);
}
