import 'package:app_settings/app_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  final _audioQuery = OnAudioQuery();

  IntroBloc() : super(IntroIdleState()) {
    on<IntroAskPermissionEvent>(_askPermission);
    on<IntroCheckPermissionEvent>(_checkPermission);
    on<IntroOpenAppSettingsEvent>(_openAppSettings);
  }

  void _askPermission(
    IntroAskPermissionEvent event,
    Emitter<IntroState> emit,
  ) async {
    if (await _audioQuery.checkAndRequest()) {
      emit(IntroGoToHomeState());
    }
  }

  void _checkPermission(
    IntroCheckPermissionEvent event,
    Emitter<IntroState> emit,
  ) async {
    if (await _audioQuery.permissionsStatus()) {
      emit(IntroGoToHomeState());
    }
  }

  void _openAppSettings(
    IntroOpenAppSettingsEvent event,
    Emitter<IntroState> emit,
  ) async {
    await AppSettings.openAppSettings();
    if (await _audioQuery.permissionsStatus()) {
      emit(IntroGoToHomeState());
    }
  }
}
