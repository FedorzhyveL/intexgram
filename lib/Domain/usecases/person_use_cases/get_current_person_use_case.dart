import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class GetCurrentPersonUseCase
    extends UseCase<PersonEntity, GetCurrentPersonParams> {
  PersonRepository personRepository;
  GetCurrentPersonUseCase(this.personRepository);

  @override
  Future<Either<Failure, PersonEntity>> call(
      GetCurrentPersonParams params) async {
    return await personRepository.getPerson(
      params.email,
      params.fromCache,
    );
  }
}

class GetCurrentPersonParams extends Equatable {
  final String email;
  final bool fromCache;

  const GetCurrentPersonParams({required this.email, required this.fromCache});
  @override
  List<Object?> get props => [];
}
