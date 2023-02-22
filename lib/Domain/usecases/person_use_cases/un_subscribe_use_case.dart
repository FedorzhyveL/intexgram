import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class UnSubscribeUseCase extends UseCase<void, UnSubscribeParams> {
  PersonRepository personRepository;
  UnSubscribeUseCase(this.personRepository);

  @override
  Future<Either<Failure, void>> call(UnSubscribeParams params) async {
    return await personRepository.unSubscribe(params.userEmail);
  }
}

class UnSubscribeParams extends Equatable {
  final String userEmail;

  const UnSubscribeParams({required this.userEmail});
  @override
  List<Object?> get props => [];
}
