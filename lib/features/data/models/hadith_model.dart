import 'package:hadith_app/features/domain/entity/hadith_entity.dart';

class HadithModel extends HadithEntity {
  HadithModel(
      {required String id,
      required String name,
      required String text,
      required String explanation,
      required String translate,
      required String audio,
      required bool isFav})
      : super(
            id: id,
            name: name,
            text: text,
            explanation: explanation,
            translate: translate,
            audio: audio,
            isFavourite: isFav);
  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
        id: json['key'],
        name: json['nameHadith'],
        text: json['textHadith'],
        explanation: json['explanationHadith'],
        translate: json['translateNarrator'],
        audio: json['audioHadith'],
        isFav: json['isFavourite']);
  }
  Map<String, dynamic> toJson() {
    return {
      'key': id,
      'nameHadith': name,
      'textHadith': text,
      'explanationHadith': explanation,
      'translateNarrator': translate,
      'audioHadith': audio,
      "isFavourite": isFavourite
    };
  }
}
