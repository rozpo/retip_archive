import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistsView extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final AudioPlayer player;

  const ArtistsView({
    required this.navigatorKey,
    required this.player,
    super.key,
  });

  @override
  State<ArtistsView> createState() => _ArtistsViewState();
}

class _ArtistsViewState extends State<ArtistsView> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArtistModel>>(
      future: _audioQuery.queryArtists(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      ),
      builder: (context, item) {
        if (item.hasError) {
          return Center(
            child: Text(item.error.toString()),
          );
        }

        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (item.data!.isEmpty) {
          return const Center(
            child: Text("Nothing found!"),
          );
        }

        return ListView.builder(
          itemCount: item.data!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(item.data![index].artist),
              subtitle: Text(
                'Albums: ${item.data![index].numberOfAlbums}',
              ),
              trailing: const Icon(Icons.more_vert),
              leading: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(5),
                controller: _audioQuery,
                id: item.data![index].id,
                type: ArtworkType.ARTIST,
              ),
              onTap: () => widget.navigatorKey.currentState!.pushNamed('second'),
            );
          },
        );
      },
    );
  }
}
