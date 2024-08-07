import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:retip/app/pages/home/home_page.dart';
import 'package:retip/app/pages/library/library_page.dart';
import 'package:retip/app/pages/settings/settings_page.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class RetipLayout extends StatefulWidget {
  final String title;
  final Widget body;

  const RetipLayout({
    required this.title,
    required this.body,
    super.key,
  });

  @override
  State<RetipLayout> createState() => _RetipLayoutState();
}

class _RetipLayoutState extends State<RetipLayout> {
  int index = 1;

  final PageController pageController = PageController(
    initialPage: 1,
  );

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
        // appBar: AppBar(
        //   title: Text(widget.title),
        //   bottom: TabBar(
        //     isScrollable: false,
        //     tabs: tabs.map((tab) => Tab(text: tab)).toList(),
        //   ),
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.grid_view_outlined),
        //       onPressed: () {},
        //     ),
        //   ],
        // ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          scrollDirection: Axis.horizontal,
          children: [
            const LibraryPage(),
            // HomePage(audioPlayer: AudioPlayer()),
            const SettingsPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          currentIndex: index,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.outline,
          onTap: (value) {
            index = value;
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear,
            );

            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.library_music),
              icon: const Icon(Icons.library_music_outlined),
              label: RetipL10n.of(context).library,
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/common/icons/retip.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              icon: SvgPicture.asset(
                'assets/common/icons/retip.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.outline,
                  BlendMode.srcIn,
                ),
              ),
              label: RetipL10n.of(context).home,
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.settings),
              icon: const Icon(Icons.settings_outlined),
              label: RetipL10n.of(context).settings,
            ),
          ],
        ),
      ),
    );
  }
}
