part of 'hadith_cubit.dart';

abstract class HadithState extends Equatable {
  const HadithState();

  @override
  List<Object> get props => [];
}

class HadithInitial extends HadithState {}

class HadithLoading extends HadithState {}

class HadithError extends HadithState {
  final String massage;

  const HadithError({required this.massage});
  @override
  List<Object> get props => [massage];
}

class HadithLoaded extends HadithState {
  final List<HadithEntity> hadithEntity;

  const HadithLoaded({required this.hadithEntity});
  @override
  List<Object> get props => [hadithEntity];
}

class HadithPlayAudio extends HadithState {
  @override
  List<Object> get props => [];
}

class HadithPlayListAudio extends HadithState {
  List<Duration> duration;
  List<Duration> position;
  HadithPlayListAudio({required this.duration, required this.position});
  @override
  List<Object> get props => [position, duration];
}

class HadithLoadingAudio extends HadithState {
  @override
  List<Object> get props => [];
}

class HadithPauseAudio extends HadithState {
  @override
  List<Object> get props => [];
}

class HadithStopAudio extends HadithState {
  @override
  List<Object> get props => [];
}

class HadithResumeAudio extends HadithState {
  @override
  List<Object> get props => [];
}

class FavouriteHadithLoading extends HadithState {
  @override
  List<Object> get props => [];
}

class FavouriteHadithError extends HadithState {
  @override
  List<Object> get props => [];
}

class FavouriteHadith extends HadithState {
  final HadithEntity hadithEntity;

  const FavouriteHadith({required this.hadithEntity});
  @override
  List<Object> get props => [hadithEntity];
}

class FavouriteHadithRemove extends HadithState {
  const FavouriteHadithRemove();
  @override
  List<Object> get props => [];
}

class FavouriteHadithLoaded extends HadithState {
  final List<HadithEntity> hadithEntity;

  const FavouriteHadithLoaded({required this.hadithEntity});
  @override
  List<Object> get props => [hadithEntity];
}

class FavouriteHadithAudioPlaying extends HadithState {
  final List<AudioPlayer> audioPlayer;

  const FavouriteHadithAudioPlaying({required this.audioPlayer});
  @override
  List<Object> get props => [audioPlayer];
}
