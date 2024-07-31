import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class HomePage extends StatelessWidget {
  final OnAudioQuery audioQuery;

  const HomePage({
    required this.audioQuery,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RetipL10n.of(context).retipTitle),
      ),
      body: Center(
        child: FutureBuilder<List<SongModel>>(
          // Default values:
          future: audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, item) {
            if (item.hasError) {
              return Text(item.error.toString());
            }

            if (item.data == null) {
              return const CircularProgressIndicator();
            }

            if (item.data!.isEmpty) return const Text("Nothing found!");

            return ListView.builder(
              itemCount: item.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(item.data![index].title),
                  subtitle: Text(item.data![index].artist ?? "No Artist"),
                  trailing: const Icon(Icons.arrow_forward_rounded),
                  leading: QueryArtworkWidget(
                    controller: audioQuery,
                    id: item.data![index].id,
                    type: ArtworkType.AUDIO,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
