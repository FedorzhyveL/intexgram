import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class ChangePhotoUseCase extends UseCase<void, ChangePhotoParams> {
  PersonRepository personRepository;
  ChangePhotoUseCase(this.personRepository);

  @override
  Future<Either<Failure, void>> call(ChangePhotoParams params) async {
    return await personRepository.changeUserPhoto(params.photo);
  }
}

class ChangePhotoParams extends Equatable {
  final File photo;

  const ChangePhotoParams({required this.photo});
  @override
  List<Object?> get props => [];
}
