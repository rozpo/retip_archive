part of 'intro_bloc.dart';

@immutable
sealed class IntroEvent {}

class IntroCheckPermissionEvent extends IntroEvent {}

class IntroAskPermissionEvent extends IntroEvent {}

class IntroOpenAppSettingsEvent extends IntroEvent {}
