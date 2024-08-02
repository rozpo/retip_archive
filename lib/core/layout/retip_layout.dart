import 'package:flutter/material.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class RetipLayout extends StatelessWidget {
  final String title;
  final Widget body;

  const RetipLayout({
    required this.title,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      RetipL10n.of(context).genres,
      RetipL10n.of(context).artists,
      RetipL10n.of(context).albums,
      RetipL10n.of(context).songs,
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            isScrollable: false,
            tabs: tabs.map((tab) => Tab(text: tab)).toList(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.grid_view_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          items: [
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.queue_music),
              icon: const Icon(Icons.queue_music_outlined),
              label: RetipL10n.of(context).playlists,
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.headphones),
              icon: const Icon(Icons.headphones_outlined),
              label: RetipL10n.of(context).home,
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.library_music),
              icon: const Icon(Icons.library_music_outlined),
              label: RetipL10n.of(context).library,
            ),
          ],
        ),
      ),
    );
  }
}
