import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w10/data/repositories/artist/artist_repository.dart';
import 'package:mobile_dev_w4/w10/data/repositories/comment/comment_repository.dart';
import 'package:mobile_dev_w4/w10/data/repositories/songs/song_repository.dart';
import 'package:mobile_dev_w4/w10/model/artist/artist.dart';
import 'package:mobile_dev_w4/w10/ui/screens/artists/view_model/artist_detail_viewmodel.dart';
import 'package:mobile_dev_w4/w10/ui/screens/artists/widgets/artist_detail_content.dart';
import 'package:mobile_dev_w4/w10/ui/states/player_state.dart';
import 'package:provider/provider.dart';

class ArtistDetailPage extends StatelessWidget {
  final Artist artist;
  const ArtistDetailPage({required this.artist ,super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArtistDetailViewmodel(
        playerState: context.read<PlayerState>(),
        songRepository: context.read<SongRepository>(),
        commentRepository: context.read<CommentRepository>(),
        artist: artist,
      ),
      child: ArtistDetailContent(artist: artist,),
    );
  }
}
