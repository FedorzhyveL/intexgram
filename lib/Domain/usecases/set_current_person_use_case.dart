import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class SetCurrentPersonUseCase extends UseCase<void, CurrentPersonParams> {
  PersonRepository personRepository;
  SetCurrentPersonUseCase(this.personRepository);

  @override
  Future<Either<Failure, void>> call(CurrentPersonParams params) async {
    return personRepository.setPerson(
        params.email, params.password, params.nickName, params.userName);
  }
}

class CurrentPersonParams extends Equatable {
  final String email;
  final String password;
  final String nickName;
  final String userName;

  const CurrentPersonParams(
      {required this.email,
      required this.password,
      required this.nickName,
      required this.userName});
  @override
  List<Object?> get props => [email];
}
