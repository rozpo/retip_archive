import 'package:retip/app/data/repositories/on_audio_query_repository.dart';
import 'package:retip/app/services/entities/track_entity.dart';
import 'package:retip/app/services/repositories/track_repository.dart';

class GetAllTracks {
  final TrackRepository _trackRepository = OnAudioQueryRepository();

  Future<List<TrackEntity>> call() async {
    return _trackRepository.getAllTracks();
  }
}
