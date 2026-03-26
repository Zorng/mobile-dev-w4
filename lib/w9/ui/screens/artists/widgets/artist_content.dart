import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w9/model/artists/artist.dart';
import 'package:mobile_dev_w4/w9/ui/screens/artists/viewmodel/artists_viewmodel.dart';
import 'package:mobile_dev_w4/w9/ui/screens/artists/widgets/artist_tile.dart';
import 'package:mobile_dev_w4/w9/ui/theme/theme.dart';
import 'package:mobile_dev_w4/w9/ui/utils/async_value.dart';
import 'package:provider/provider.dart';

class ArtistContent extends StatelessWidget {
  const ArtistContent({super.key});

  @override
  Widget build(BuildContext context) {
    ArtistsViewmodel vm = context.watch<ArtistsViewmodel>();

    AsyncValue<List<Artist>> asyncValue = vm.artistsValue;

    Widget content;
    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error!}',
            style: TextStyle(color: Colors.red),
          ),
        );

      case AsyncValueState.success:
        List<Artist> artists = asyncValue.data!;
        content = ListView.builder(
          itemCount: artists.length,
          itemBuilder: (context, index) => ArtistTile(
            artist: artists[index],
          ),
        );
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Artists", style: AppTextStyles.heading),
          SizedBox(height: 50),

          Expanded(child: content),
        ],
      ),
    );
  }
}
