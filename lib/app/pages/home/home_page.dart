import 'package:flutter/material.dart';
import 'package:retip/app/pages/home/widgets/retip_icon.dart';
import 'package:retip/app/pages/library/library_page.dart';
import 'package:retip/app/pages/settings/settings_page.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _initialIndex = 1;
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
                  LibraryPage(navigatorKey: _navigatorKey),
                  const Placeholder(),
                  const SettingsPage(),
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
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.library_music),
            label: RetipL10n.of(context).library,
          ),
          BottomNavigationBarItem(
            activeIcon: RetipIcon(color: colorScheme.primary),
            icon: RetipIcon(color: colorScheme.outline),
            label: RetipL10n.of(context).home,
          ),
          BottomNavigationBarItem(
            activeIcon: const Icon(Icons.settings),
            icon: const Icon(Icons.settings_outlined),
            label: RetipL10n.of(context).settings,
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
