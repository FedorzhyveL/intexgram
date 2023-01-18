import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class DeleteUserPhotoUseCase extends UseCase<void, DeleteUserPhotoParams> {
  PersonRepository personRepository;
  DeleteUserPhotoUseCase(this.personRepository);

  @override
  Future<Either<Failure, void>> call(DeleteUserPhotoParams params) async {
    return await personRepository.deleteUserPhoto(params.userEmail);
  }
}

class DeleteUserPhotoParams extends Equatable {
  final String userEmail;

  const DeleteUserPhotoParams({required this.userEmail});
  @override
  List<Object?> get props => [];
}
