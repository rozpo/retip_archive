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

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          LibraryPage(),
          Placeholder(),
          SettingsPage(),
        ],
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
