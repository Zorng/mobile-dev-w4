import 'package:mobile_dev_w4/w8/data/repositories/songs/song_repository.dart';
import 'package:mobile_dev_w4/w8/data/repositories/songs/song_repository_mock.dart';

void main() async {
  SongRepository songRepository = SongRepositoryMock();
  // Test both the success and the failure of the post request

  try {
    final song = await songRepository.fetchSongById("s1");
    print("song found");
    print(song);
  } catch (e) {
    print(e);
  } finally {
    print("finished");
  }
  
  // Handle the Future using 2 ways  (2 tests)
  // - Using then() with .catchError().
  // - Using async/await with try/catch.
}
