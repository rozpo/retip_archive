import 'package:on_audio_query/on_audio_query.dart';
import 'package:retip/app/services/entities/track_entity.dart';

class TrackModel extends TrackEntity {
  TrackModel({
    required super.title,
    required super.album,
    required super.artist,
  });

  factory TrackModel.fromSongModel(SongModel data) {
    return TrackModel(
      title: data.title,
      album: data.album ?? "",
      artist: data.artist ?? "",
    );
  }
}
