import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class SetCurrentPersonUseCase extends UseCase<void, SetCurrentPersonParams> {
  PersonRepository personRepository;
  SetCurrentPersonUseCase(this.personRepository);

  @override
  Future<Either<Failure, void>> call(SetCurrentPersonParams params) async {
    return await personRepository.setPerson(
      params.email,
      params.password,
      params.nickName,
      params.userName,
      params.profileImagePath,
      params.description,
    );
  }
}

class SetCurrentPersonParams extends Equatable {
  final String email;
  final String password;
  final String nickName;
  final String userName;
  final String profileImagePath;
  final String? description;

  const SetCurrentPersonParams({
    required this.profileImagePath,
    required this.email,
    required this.password,
    required this.nickName,
    required this.userName,
    this.description,
  });
  @override
  List<Object?> get props => [email];
}
