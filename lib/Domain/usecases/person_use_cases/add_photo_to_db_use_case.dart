import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class AddPhotoToDbUseCase extends UseCase<void, AddPhotoToDbParams> {
  PersonRepository personRepository;
  AddPhotoToDbUseCase(this.personRepository);

  @override
  Future<Either<Failure, void>> call(AddPhotoToDbParams params) async {
    return await personRepository.addPhotoToDb(params.photo);
  }
}

class AddPhotoToDbParams extends Equatable {
  final File photo;

  const AddPhotoToDbParams({required this.photo});
  @override
  List<Object?> get props => [];
}
