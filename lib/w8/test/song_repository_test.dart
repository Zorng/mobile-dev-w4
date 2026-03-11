import 'package:mobile_dev_w4/w8/data/repositories/songs/song_repository.dart';
import 'package:mobile_dev_w4/w8/data/repositories/songs/song_repository_mock.dart';

void main() async {
  //   Instantiate the  song_repository_mock

  // Test both the success and the failure of the post request

  // Handle the Future using 2 ways  (2 tests)
  // - Using then() with .catchError().
  // - Using async/await with try/catch
  SongRepository repository = SongRepositoryMock();

  try {
    final song = await repository.fetchSongById("s2");
    print("Song found, $song");
  } catch (e) {
    print(e);
  }
}
