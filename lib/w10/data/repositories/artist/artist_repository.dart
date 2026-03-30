import '../../../model/artist/artist.dart';
 

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists(); //call api

  Future<List<Artist>> getArtists({bool forceFetch}); //called from cache
  
  Future<Artist?> fetchArtistById(String id);
}
