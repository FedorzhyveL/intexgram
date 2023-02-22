import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/core/error/failure.dart';

abstract class PersonRepository {
  Future<Either<Failure, PersonEntity>> getPerson(
    String email,
    bool fromCache,
  );

  Future<Either<Failure, List<PersonEntity>>> getAllPersons();

  Future<Either<Failure, List<PersonEntity>>> getPersonsFromCollection(
    String firstCollectionName,
    String secondCollectionName,
    String docId,
  );

  Future<Either<Failure, void>> setPerson(
    String email,
    String password,
    String nickName,
    String userName,
    String profileImagePath,
    String? description,
  );

  Future<Either<Failure, void>> updatePerson(
    String email,
    String nickName,
    String userName,
    String? profileImagePath,
    String? description,
  );

  Future<Either<Failure, bool>> checkSubscription(
    String email,
  );

  Future<Either<Failure, void>> changeUserPhoto(
    File photo,
  );

  Future<Either<Failure, void>> subscribe(
    String userEmail,
  );

  Future<Either<Failure, void>> unSubscribe(
    String userEmail,
  );
}
