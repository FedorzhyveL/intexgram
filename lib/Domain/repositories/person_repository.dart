import 'package:dartz/dartz.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/core/error/failure.dart';

abstract class PersonRepository {
  Future<Either<Failure, PersonEntity>> getPerson(String email, bool fromCache);
  Future<Either<Failure, void>> setPerson(
      String email, String password, String nickName, String userName);
}
