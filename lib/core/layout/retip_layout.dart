import 'package:flutter/material.dart';

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
      'Genres',
      'Artists',
      'Albums',
      'Songs',
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
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.library_music),
              icon: Icon(Icons.library_music_outlined),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.headphones),
              icon: Icon(Icons.headphones_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
