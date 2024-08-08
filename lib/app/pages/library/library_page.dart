import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:retip/app/views/albums/albums_view.dart';
import 'package:retip/app/views/artists/artists_view.dart';
import 'package:retip/app/views/songs/songs_view.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class LibraryPage extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const LibraryPage({
    required this.navigatorKey,
    super.key,
  });

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final player = AudioPlayer();
  final List<Widget> pages = [];

  @override
  void initState() {
    pages.addAll([
      ArtistsView(
        player: player,
        navigatorKey: widget.navigatorKey,
      ),
      AlbumsView(player: player),
      SongsView(player: player),
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(RetipL10n.of(context).library),
          bottom: TabBar(
            tabs: [
              Tab(text: RetipL10n.of(context).artists),
              Tab(text: RetipL10n.of(context).albums),
              Tab(text: RetipL10n.of(context).songs),
            ],
          ),
        ),
        body: TabBarView(children: pages),
      ),
    );
  }
}
