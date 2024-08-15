import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:retip/app/views/albums/albums_view.dart';
import 'package:retip/app/views/artists/artists_view.dart';
import 'package:retip/app/views/songs/songs_view.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class LibraryView extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const LibraryView({
    required this.navigatorKey,
    super.key,
  });

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  final player = AudioPlayer();

  bool isSearching = false;
  String query = '';

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: isSearching
              ? SearchBar(
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                  controller: _searchController,
                  hintText: 'Search library...',
                  elevation: WidgetStatePropertyAll(0),
                  shape: WidgetStatePropertyAll(LinearBorder()),
                  autoFocus: true,
                  leading: const Icon(Icons.search),
                  trailing: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isSearching = false;
                          query = '';
                          _searchController.text = '';
                        });
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                )
              : Text(RetipL10n.of(context).library),
          actions: isSearching
              ? null
              : [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                    icon: const Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.sort),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.grid_view),
                  ),
                ],
          bottom: TabBar(
            tabs: [
              Tab(text: RetipL10n.of(context).artists),
              Tab(text: RetipL10n.of(context).albums),
              Tab(text: RetipL10n.of(context).songs),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ArtistsView(
              player: player,
              navigatorKey: widget.navigatorKey,
              // query: query,
            ),
            AlbumsView(
              player: player,
              // query: query,
            ),
            SongsView(
              player: player,
              query: query,
            ),
          ],
        ),
      ),
    );
  }
}
