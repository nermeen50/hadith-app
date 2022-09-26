import 'dart:developer';

import 'package:hadith_app/core/local_api/end_points.dart';
import 'package:hadith_app/core/local_api/local_consumer.dart';
import 'package:hadith_app/features/data/models/hadith_model.dart';

abstract class HadithDataSource {
  Future<List<HadithModel>> getHadithData();
}

class HadithDataSourceImpl implements HadithDataSource {
  final ApiConsumer apiConsumer;
  HadithDataSourceImpl({required this.apiConsumer});
  @override
  Future<List<HadithModel>> getHadithData() async {
    final response = await apiConsumer.readJson(EndPoints.hadithFilePath);
    List<HadithModel> hadith = response['hadith']
        .map<HadithModel>((hadith) => HadithModel.fromJson(hadith))
        .toList();
    log("hadith response $response ");
    return Future.value(hadith);
  }
}
