import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:retip/app/pages/home/bloc/home_bloc.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class HomePage extends StatefulWidget {
  final AudioPlayer audioPlayer;

  const HomePage({
    required this.audioPlayer,
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      RetipL10n.of(context).favorite,
      RetipL10n.of(context).playlists,
      RetipL10n.of(context).genres,
      RetipL10n.of(context).artists,
      RetipL10n.of(context).albums,
      RetipL10n.of(context).songs,
    ];

    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeRefreshEvent()),
      child: DefaultTabController(
        initialIndex: index,
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(RetipL10n.of(context).retipTitle),
            bottom: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: tabs.map((tab) => Tab(text: tab)).toList(),
            ),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.favorite),
              Icon(Icons.queue_music),
              Icon(Icons.disc_full),
              Icon(Icons.person),
              Icon(Icons.album),
              Icon(Icons.music_note),
            ],
          ),
          // body: BlocBuilder<HomeBloc, HomeState>(
          //   builder: (context, state) {
          //     if (state is HomeIdleState) {
          //       return RefreshIndicator(
          //         onRefresh: () async {
          //           context.read<HomeBloc>().add(HomeRefreshEvent());
          //         },
          //         child: ListView.builder(
          //           itemCount: state.songs.length,
          //           itemBuilder: (context, index) {
          //             final song = state.songs[index];

          //             return ListTile(
          //               title: Text(song.title),
          //               subtitle:
          //                   song.artist != null ? Text(song.artist!) : null,
          //               onTap: () {
          //                 if (song.uri != null) {
          //                   widget.audioPlayer.stop();
          //                   widget.audioPlayer.setUrl(song.uri!);
          //                   widget.audioPlayer.play();
          //                 }
          //               },
          //             );
          //           },
          //         ),
          //       );
          //     } else if (state is HomeLoadingState) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }

          //     return const Center(
          //       child: Text('Error'),
          //     );
          //   },
        ),
      ),
    );
  }
}
