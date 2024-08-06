part of 'intro_bloc.dart';

@immutable
sealed class IntroState {}

final class IntroIdleState extends IntroState {}

final class IntroGoToHomeState extends IntroState {}
