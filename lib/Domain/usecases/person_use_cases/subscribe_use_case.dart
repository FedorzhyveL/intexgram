import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class SubscribeUseCase extends UseCase<void, SubscribeParams> {
  PersonRepository personRepository;
  SubscribeUseCase(this.personRepository);

  @override
  Future<Either<Failure, void>> call(SubscribeParams params) async {
    return await personRepository.subscribe(params.userEmail);
  }
}

class SubscribeParams extends Equatable {
  final String userEmail;

  const SubscribeParams({required this.userEmail});
  @override
  List<Object?> get props => [];
}
