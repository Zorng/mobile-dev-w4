import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w9/model/artists/artist.dart';

class ArtistTile extends StatelessWidget {
  final Artist artist;
  const ArtistTile({required this.artist, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(artist.imageUrl.toString()),
          ),
          title: Text(artist.name),
          subtitle: Text(artist.genre.value),
        ),
      ),
    );
  }

}
