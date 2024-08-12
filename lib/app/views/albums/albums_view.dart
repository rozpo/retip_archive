import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:retip/app/views/album/album_view.dart';

class AlbumsView extends StatefulWidget {
  final AudioPlayer player;

  const AlbumsView({
    required this.player,
    super.key,
  });

  @override
  State<AlbumsView> createState() => _AlbumsViewState();
}

class _AlbumsViewState extends State<AlbumsView> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AlbumModel>>(
      future: _audioQuery.queryAlbums(
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
              title: Text(
                item.data![index].album,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Text(
                '${item.data![index].artist}',
              ),
              trailing: const Icon(Icons.more_vert),
              leading: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(5),
                controller: _audioQuery,
                id: item.data![index].id,
                type: ArtworkType.ALBUM,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AlbumView(
                        albumTitle: item.data![index].album,
                        albumId: '',
                        player: widget.player,
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
