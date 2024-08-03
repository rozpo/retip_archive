import 'package:flutter/material.dart';
import 'package:retip/app/views/albums/albums_view.dart';
import 'package:retip/app/views/artists/artists_view.dart';
import 'package:retip/app/views/songs/songs_view.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final pages = const [
    ArtistsView(),
    AlbumsView(),
    SongsView(),
  ];

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
