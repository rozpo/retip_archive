import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumView extends StatefulWidget {
  final String albumTitle;
  final String albumId;

  final AudioPlayer player;

  const AlbumView({
    required this.albumTitle,
    required this.albumId,
    required this.player,
    super.key,
  });

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.albumTitle),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _audioQuery.queryWithFilters(
          widget.albumTitle,
          WithFiltersType.AUDIOS,
          args: WithFiltersType.ALBUMS,
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

          final songs = item.data!.map((e) => SongModel(e)).toList();

          final playlist = ConcatenatingAudioSource(
            children: songs.map(
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
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  songs[index].title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${songs[index].album}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      '${songs[index].artist}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                trailing: const Icon(Icons.more_vert),
                leading: QueryArtworkWidget(
                  artworkBorder: BorderRadius.circular(5),
                  controller: _audioQuery,
                  id: songs[index].id,
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
      ),
    );
  }
}
