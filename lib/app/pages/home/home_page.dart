import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retip/app/pages/home/bloc/home_bloc.dart';
import 'package:retip/core/l10n/retip_l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeRefreshEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(RetipL10n.of(context).retipTitle),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeIdleState) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeBloc>().add(HomeRefreshEvent());
                },
                child: ListView.builder(
                  itemCount: state.songs.length,
                  itemBuilder: (context, index) {
                    final song = state.songs[index];

                    return ListTile(
                      title: Text(song.title),
                      subtitle: song.artist != null ? Text(song.artist!) : null,
                    );
                  },
                ),
              );
            } else if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const Center(
              child: Text('Error'),
            );
          },
        ),
      ),
    );
  }
}
