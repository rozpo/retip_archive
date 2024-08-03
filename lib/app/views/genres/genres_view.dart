import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GenresView extends StatefulWidget {
  const GenresView({super.key});

  @override
  State<GenresView> createState() => _GenresViewState();
}

class _GenresViewState extends State<GenresView> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GenreModel>>(
      future: _audioQuery.queryGenres(
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
              title: Text(item.data![index].genre),
              subtitle: Text('Songs: ${item.data![index].numOfSongs}'),
              trailing: const Icon(Icons.more_vert),
              leading: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(5),
                controller: _audioQuery,
                id: item.data![index].id,
                type: ArtworkType.GENRE,
              ),
            );
          },
        );
      },
    );
  }
}
