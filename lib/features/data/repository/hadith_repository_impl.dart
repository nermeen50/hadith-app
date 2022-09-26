import 'package:hadith_app/core/errors/excaptions.dart';
import 'package:hadith_app/features/data/data_sources/hadith_data_source.dart';
import 'package:hadith_app/features/data/models/hadith_model.dart';
import 'package:hadith_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hadith_app/features/domain/repository/hadith_repository.dart';

class HadithRepositoryImpl implements HadithRepository {
  final HadithDataSource hadithDataSource;

  HadithRepositoryImpl({required this.hadithDataSource});
  @override
  Future<Either<Failure, List<HadithModel>>> getHaith() async {
    try {
      final response = await hadithDataSource.getHadithData();
      return right(response);
    } on CacheExcaptions {
      return left(CacheFailuer());
    }
  }
}
