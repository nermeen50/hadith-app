import 'package:equatable/equatable.dart';

class HadithEntity extends Equatable {
  final String id;
  final String name;
  final String text;
  final String explanation;
  final String translate;
  final String audio;
  bool isFavourite;

  HadithEntity(
      {required this.id,
      required this.name,
      required this.text,
      required this.explanation,
      required this.translate,
      required this.audio,
      required this.isFavourite});

  @override
  List<Object?> get props =>
      [id, name, text, explanation, translate, audio, isFavourite];
}
