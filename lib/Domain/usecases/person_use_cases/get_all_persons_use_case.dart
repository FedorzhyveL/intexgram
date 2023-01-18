import 'package:dartz/dartz.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class GetAllPersonsUseCase extends UseCase<List<PersonEntity>, void> {
  PersonRepository personRepository;
  GetAllPersonsUseCase(this.personRepository);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(params) async {
    return await personRepository.getAllPersons();
  }
}
