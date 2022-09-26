import 'package:dartz/dartz.dart';
import 'package:hadith_app/core/errors/failure.dart';
import 'package:hadith_app/features/domain/entity/hadith_entity.dart';

abstract class HadithRepository {
  Future<Either<Failure, List<HadithEntity>>> getHaith();
}
