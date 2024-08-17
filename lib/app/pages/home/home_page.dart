import 'package:flutter/material.dart';
import 'package:retip/app/pages/home/views/explore/explore_view.dart';
import 'package:retip/app/pages/home/views/search/search_view.dart';
import 'package:retip/app/pages/home/widgets/retip_icon.dart';
import 'package:retip/app/pages/home/views/library/library_view.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _initialIndex = 0;
  int index = _initialIndex;

  final PageController pageController = PageController(
    initialPage: _initialIndex,
  );

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        initialRoute: 'main',
        onGenerateRoute: (settings) {
          final page = switch (settings.name) {
            'main' => PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const ExploreView(),
                  const SearchView(),
                  LibraryView(navigatorKey: _navigatorKey),
                ],
              ),
            'second' => Scaffold(
                body: Container(
                  color: Colors.red,
                ),
              ),
            _ => throw StateError('Unexpected route'),
          };

          return MaterialPageRoute(
            builder: (context) {
              return page;
            },
            settings: settings,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: colorScheme.outline,
        fixedColor: colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            activeIcon: RetipIcon(color: colorScheme.primary),
            icon: RetipIcon(color: colorScheme.outline),
            label: RetipL10n.of(context).home,
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(Icons.search),
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.library_music),
            label: RetipL10n.of(context).library,
          ),
        ],
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });

          if (_navigatorKey.currentState!.canPop()) {
            _navigatorKey.currentState!.pop();
          }

          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
