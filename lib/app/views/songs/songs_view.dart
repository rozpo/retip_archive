import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsView extends StatefulWidget {
  final AudioPlayer player;

  const SongsView({
    required this.player,
    super.key,
  });

  @override
  State<SongsView> createState() => _SongsViewState();
}

class _SongsViewState extends State<SongsView> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
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

        final playlist = ConcatenatingAudioSource(
          children: item.data!.map(
            (element) {
              return AudioSource.uri(Uri.parse(element.uri!));
            },
          ).toList(),
        );

        return ListView.builder(
          itemCount: item.data!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                item.data![index].title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.data![index].album}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    '${item.data![index].artist}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              trailing: const Icon(Icons.more_vert),
              leading: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(5),
                controller: _audioQuery,
                id: item.data![index].id,
                type: ArtworkType.AUDIO,
              ),
              onTap: () {
                widget.player.stop();

                widget.player.setAudioSource(
                  playlist,
                  initialIndex: index,
                  initialPosition: Duration.zero,
                );

                widget.player.play();
              },
            );
          },
        );
      },
    );
  }
}
