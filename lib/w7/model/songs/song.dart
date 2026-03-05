class Song {
  final String id;
  final String title;
  final String artist;
  final Duration duration;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
  });

  // for list generation
  Song.dummy()
    : id = "dummy",
      title = "dummy",
      artist = "dummy",
      duration = Duration();

  @override
  bool operator ==(Object other) {
    return other is Song &&
        other.id == id &&
        other.artist == artist &&
        other.duration == duration &&
        other.title == title;
  }

  @override
  int get hashCode => Object.hash(id, title, artist, duration);
}
