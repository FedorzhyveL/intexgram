import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class CheckSubscriptionUseCase extends UseCase<bool, CheckSubscriptionParams> {
  PersonRepository personRepository;
  CheckSubscriptionUseCase(this.personRepository);

  @override
  Future<Either<Failure, bool>> call(CheckSubscriptionParams params) async {
    return await personRepository.checkSubscription(params.email);
  }
}

class CheckSubscriptionParams extends Equatable {
  final String email;

  const CheckSubscriptionParams({required this.email});
  @override
  List<Object?> get props => [];
}
