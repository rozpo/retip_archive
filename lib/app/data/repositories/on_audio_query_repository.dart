import '../../services/repositories/track_repository.dart';
import '../models/track_model.dart';
import '../providers/on_audio_query_provider.dart';

class OnAudioQueryRepository implements TrackRepository {
  final _onAudioQueryProvider = OnAudioQueryProvider();

  @override
  Future<List<TrackModel>> getAllTracks() async {
    final data = await _onAudioQueryProvider.getAllTracks();
    final tracks = <TrackModel>[];

    for (final element in data) {
      tracks.add(TrackModel.fromSongModel(element));
    }

    return tracks;
  }
}
