import 'package:hadith_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hadith_app/core/usecase/usecase.dart';
import 'package:hadith_app/features/domain/entity/hadith_entity.dart';
import 'package:hadith_app/features/domain/repository/hadith_repository.dart';

class HadithUseCase extends UseCase<List<HadithEntity>, NoParams> {
  final HadithRepository hadithRepository;

  HadithUseCase({required this.hadithRepository});

  @override
  Future<Either<Failure, List<HadithEntity>>> call(NoParams param) {
    return hadithRepository.getHaith();
  }
}
