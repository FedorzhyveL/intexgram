import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class GetPersonsFromCollectionUseCase
    extends UseCase<List<PersonEntity>, GetPersonsFromCollectionParams> {
  PersonRepository personRepository;
  GetPersonsFromCollectionUseCase(this.personRepository);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      GetPersonsFromCollectionParams params) async {
    return await personRepository.getPersonsFromCollection(
      params.firstCollectionName,
      params.secondCollectionName,
      params.docId,
    );
  }
}

class GetPersonsFromCollectionParams extends Equatable {
  final String firstCollectionName;
  final String secondCollectionName;
  final String docId;

  const GetPersonsFromCollectionParams(
    this.firstCollectionName,
    this.secondCollectionName,
    this.docId,
  );
  @override
  List<Object?> get props => [];
}
