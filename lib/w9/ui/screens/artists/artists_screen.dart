import 'package:flutter/widgets.dart';
import 'package:mobile_dev_w4/w9/data/repositories/artists/artitst_repository.dart';
import 'package:mobile_dev_w4/w9/ui/screens/artists/viewmodel/artists_viewmodel.dart';
import 'package:mobile_dev_w4/w9/ui/screens/artists/widgets/artist_content.dart';
import 'package:provider/provider.dart';

class ArtistsScreen extends StatelessWidget {
  const ArtistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ArtistsViewmodel(repo: context.read<ArtitstRepository>()),
      child: ArtistContent(),
    );
  }
}
