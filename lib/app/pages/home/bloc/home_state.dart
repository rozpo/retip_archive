part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeIdleState extends HomeState {
  final List<SongModel> songs;

  HomeIdleState({required this.songs});
}

final class HomeLoadingState extends HomeState {}
