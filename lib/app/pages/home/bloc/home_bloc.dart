import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeIdleState(songs: const [])) {
    on<HomeRefreshEvent>(_refresh);
  }

  void _refresh(
    HomeRefreshEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());

    final audioQuery = OnAudioQuery();

    final songs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    emit(HomeIdleState(songs: songs));
  }
}
