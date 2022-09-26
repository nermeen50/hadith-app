import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hadith_app/core/errors/failure.dart';

abstract class UseCase<Type, Param> {
  @override
  Future<Either<Failure, Type>> call(Param param);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
