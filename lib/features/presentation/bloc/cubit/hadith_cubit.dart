import 'dart:convert';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hadith_app/config/common/shared_prefrance.dart';
import 'package:hadith_app/core/errors/failure.dart';
import 'package:hadith_app/core/usecase/usecase.dart';
import 'package:hadith_app/core/utils/app_strings.dart';
import 'package:hadith_app/features/data/models/hadith_model.dart';
import 'package:hadith_app/features/domain/entity/hadith_entity.dart';
import 'package:hadith_app/features/domain/usecases.dart/hadith_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'hadith_state.dart';

class HadithCubit extends Cubit<HadithState> {
  final HadithUseCase hadith;
  Duration _duration = const Duration();
  List<Duration> _durationList = <Duration>[];
  Duration _position = const Duration();
  List<Duration> _positionList = <Duration>[];
  PlayerState playerState = PlayerState.paused;
  List<PlayerState> playerStateList = <PlayerState>[];
  AudioPlayer? advancedPlayer;
  List<AudioPlayer>? advancedPlayerList;
  Duration get duration => _duration;
  List<Duration> get durationList => _durationList;
  Duration get position => _position;
  List<Duration> get positionList => _positionList;
  final Preferences preferences;
  final SharedPreferences sharedPreferences;
  List<HadithEntity> favv = [];
  bool favItem = false;
  int currentAudioPlay = 0;
  HadithCubit({
    required this.preferences,
    required this.hadith,
    required this.sharedPreferences,
  }) : super(HadithInitial());

  Future<void> getHadithData() async {
    emit(HadithLoading());
    Either<Failure, List<HadithEntity>> response = await hadith(NoParams());
    response.fold(
        (failure) => emit(const HadithError(massage: 'Error in hadith')),
        (successHadith) => emit(HadithLoaded(hadithEntity: successHadith)));
  }

  void initPlayer() async {
    advancedPlayer = AudioPlayer();
    log("advancedPlayerList $advancedPlayer");

    advancedPlayer!.onDurationChanged.listen((Duration playing) {
      _duration = playing;
    });
    advancedPlayer!.onPositionChanged.listen((event) {
      emit(HadithPlayAudio());
      _position = event;
      emit(HadithPauseAudio());
    });
    advancedPlayer!.onPlayerStateChanged.listen((PlayerState s) {
      playerState = s;
    });
    advancedPlayer!.onPlayerComplete.listen((event) {
      _position = _duration;
      emit(HadithPlayAudio());
    });
  }

  void initPlayerList(int listLength) async {
    advancedPlayerList = List.generate(listLength, (_) => AudioPlayer());
    _durationList = List.generate(listLength, (_) => const Duration());
    _positionList = List.generate(listLength, (_) => const Duration());
    // AudioPlayer x = AudioPlayer();
    // advancedPlayerList!.add(x);
  }

  void changeListAudio(int index) {
    // log("advancedPlayerList $advancedPlayerList");
    advancedPlayerList![index].onDurationChanged.listen((Duration playing) {
      _durationList[index] = playing;
      // log("_durationList $_durationList");
    });
    advancedPlayerList![index].onPositionChanged.listen((event) {
      emit(HadithPlayAudio());
      _positionList[index] = event;
      emit(HadithPauseAudio());
    });
    advancedPlayerList![index].onPlayerStateChanged.listen((PlayerState s) {
      playerStateList.add(s);
      // playerStateList[index] = s;

      log("playerStateList ${playerStateList[index].name}");
    });
    advancedPlayerList![index].onPlayerComplete.listen((event) {
      _positionList[index] = _durationList[index];
      emit(HadithPlayAudio());
    });
  }

  Future<void> play(String fileName) async {
    emit(HadithPlayAudio());
    final bytes = await AudioCache.instance.loadAsBytes("audio/$fileName");
    await advancedPlayer!.play(BytesSource(bytes));
    emit(HadithPauseAudio());
  }

  Future<void> playList(int index, String fileName) async {
    final bytes = await AudioCache.instance.loadAsBytes("audio/$fileName");
    await advancedPlayerList![index].play(BytesSource(bytes));
    log("play sate ${playerStateList[index].name}");
  }

  Future<void> pause() async {
    emit(HadithPauseAudio());
    await advancedPlayer!.pause();
    emit(HadithResumeAudio());
  }

  Future<void> pauseList(int index) async {
    await advancedPlayerList![index].pause();
  }

  void resume() async {
    await advancedPlayer!.resume();
    emit(HadithResumeAudio());
  }

  void resumeList(int index) async {
    await advancedPlayerList![index].resume();
  }

  void stopAudio() async {
    await advancedPlayer!.stop();
    _position = const Duration(seconds: 0);
    _duration = const Duration(seconds: 0);
    playerState = PlayerState.stopped;
    emit(HadithInitial());
  }

  void stopAudioList(int index) async {
    await advancedPlayerList![index].stop();
  }

  Future<void> seekToSecond(int position) async {
    Duration newDuration = Duration(seconds: position);
    position = position;
    await advancedPlayer!.seek(newDuration);
    await advancedPlayer!.resume();
  }

  Future<void> seekToSecondList(int index, int position) async {
    await advancedPlayerList![index].seek(Duration(seconds: position));
    await advancedPlayerList![index].resume();
  }

  void addHadithToFavourite(HadithEntity favHadith) async {
    if (sharedPreferences.getString(AppStrings.favHadithDataKey) != null ||
        favItem) {
      List<dynamic> jsonString = json
          .decode(sharedPreferences.getString(AppStrings.favHadithDataKey)!);
      List<HadithEntity> f =
          jsonString.map((i) => HadithModel.fromJson(i)).toList();
      f.add(favHadith);
      sharedPreferences.setString(
          AppStrings.favHadithDataKey, jsonEncode(f.toList()));
    } else {
      favv.add(favHadith);
      sharedPreferences.setString(
          AppStrings.favHadithDataKey, jsonEncode(favv.toList()));
    }
    emit(const FavouriteHadithRemove());
  }

  void removeHadithToFavourite(HadithEntity favHadith) async {
    emit(const FavouriteHadithRemove());
    if (sharedPreferences.getString(AppStrings.favHadithDataKey) != null) {
      List<dynamic> jsonString = json
          .decode(sharedPreferences.getString(AppStrings.favHadithDataKey)!);
      List<HadithEntity> f =
          jsonString.map((i) => HadithModel.fromJson(i)).toList();
      f.removeWhere((item) => item.id == favHadith.id);
      sharedPreferences.setString(
          AppStrings.favHadithDataKey, jsonEncode(f.toList()));
      favItem = false;
      log('dgggggdkkree $f');
      emit(FavouriteHadithLoaded(hadithEntity: f));
    } else {
      emit(const FavouriteHadithLoaded(hadithEntity: []));
    }
  }

  knowFavouriteHadith(HadithEntity hadith) async {
    emit(FavouriteHadithLoading());
    if (sharedPreferences.getString(AppStrings.favHadithDataKey) != null) {
      List<dynamic> jsonString = json
          .decode(sharedPreferences.getString(AppStrings.favHadithDataKey)!);
      List<HadithEntity> f =
          jsonString.map((i) => HadithModel.fromJson(i)).toList();
      log("dddddddddddd $f");
      // for (int i = 0; i < f.length; i++) {
      if (f.contains(hadith)) {
        favItem = true;
        log("fsassss $favItem");
      } else {
        favItem = false;
      }
      emit(FavouriteHadithLoaded(hadithEntity: f));
    }
  }

  getFavouriteHadith() async {
    emit(FavouriteHadithLoading());

    if (sharedPreferences.getString(AppStrings.favHadithDataKey) != null) {
      List<dynamic> jsonString = json
          .decode(sharedPreferences.getString(AppStrings.favHadithDataKey)!);
      List<HadithEntity> f =
          jsonString.map((i) => HadithModel.fromJson(i)).toList();

      // log("get fav Data ${favHadith.isFavourite}");
      // log("get favv  ${f.last.isFavourite}");
      // log("sssssssssss  ${jsonString.last}");
      emit(FavouriteHadithLoaded(hadithEntity: f));
    } else {
      emit(const FavouriteHadithLoaded(hadithEntity: []));
    }
  }
  // @override
  // Future<void> close() {
  //   advancedPlayer!.dispose();
  //   return super.close();
  // }
}
