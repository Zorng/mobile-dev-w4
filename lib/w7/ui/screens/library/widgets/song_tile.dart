import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w7/model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.onStop,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: isPlaying
          ? SizedBox(
            width: 150,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Playing", style: TextStyle(color: Colors.amber)),
                  SizedBox(width: 12,),
                  IconButton(
                    onPressed: onStop,

                    icon: Icon(Icons.stop),
                  ),
                ],
              ),
          )
          : null,
    );
  }
}
