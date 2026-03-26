enum Genre {
  pop(value: "Pop"),
  hiphop(value: "Hip-hop"),
  indie(value: "Indie");

  final String value;

  const Genre({required this.value});
}

class Artist {
  final String id;
  final String name;
  final Genre genre;
  final Uri imageUrl;

  Artist({
    required this.id,
    required this.genre,
    required this.name,
    required this.imageUrl,
  });

  @override
  String toString() {
    return "$genre, $name, $imageUrl";
  }
}
