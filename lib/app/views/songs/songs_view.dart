import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsView extends StatefulWidget {
  final AudioPlayer player;
  final String query;

  const SongsView({
    required this.query,
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

        final data = item.data!.where(
          (e) {
            return e.title.toLowerCase().contains(
                  widget.query.toLowerCase(),
                );
          },
        ).toList();

        final playlist = ConcatenatingAudioSource(
          children: data.map(
            (element) {
              return AudioSource.uri(
                Uri.parse(element.uri!),
                tag: MediaItem(
                  id: '${element.id}',
                  title: element.title,
                  artist: element.artist,
                  album: element.album,
                  duration: element.duration != null
                      ? Duration(seconds: element.duration!)
                      : null,
                ),
              );
            },
          ).toList(),
        );

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: getQueryText(data[index].title, widget.query),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data[index].album}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    '${data[index].artist}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              trailing: const Icon(Icons.more_vert),
              leading: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(5),
                controller: _audioQuery,
                id: data[index].id,
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

  RichText getQueryText(String title, String query) {
    final startIndex = title.toLowerCase().indexOf(query.toLowerCase());
    final endIndex = startIndex + query.length;
    final boldText = title.substring(startIndex, endIndex);

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          if (startIndex > 0) ...[
            TextSpan(text: title.substring(0, startIndex)),
          ],
          TextSpan(
            text: boldText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: title.substring(endIndex)),
        ],
      ),
    );
  }
}
