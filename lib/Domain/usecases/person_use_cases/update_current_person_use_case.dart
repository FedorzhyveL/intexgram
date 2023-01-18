import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class UpdateCurrentPersonUseCase
    extends UseCase<void, UpdateCurrentPersonParams> {
  PersonRepository personRepository;
  UpdateCurrentPersonUseCase(this.personRepository);

  @override
  Future<Either<Failure, void>> call(UpdateCurrentPersonParams params) async {
    return await personRepository.updatePerson(
      params.email,
      params.nickName,
      params.userName,
      params.profileImagePath,
      params.description,
    );
  }
}

class UpdateCurrentPersonParams extends Equatable {
  final String email;
  final String nickName;
  final String userName;
  final String? profileImagePath;
  final String? description;

  const UpdateCurrentPersonParams({
    required this.email,
    required this.nickName,
    required this.userName,
    this.description,
    this.profileImagePath,
  });
  @override
  List<Object?> get props => [email];
}
