import 'dart:io';

import 'package:intexgram/Data/datasources/local_datasource.dart';
import 'package:intexgram/Data/datasources/person_remote_datasource.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/exceptions.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/platform/network_info.dart';

class PersonRepositoryImpl implements PersonRepository {
  final LocalDataSource localDataSource;
  final PersonRemoteDataSource personRemoteDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.localDataSource,
    required this.personRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PersonEntity>> getPerson(
    String email,
    bool fromCahce,
  ) async {
    bool connection = await networkInfo.isConnected;
    if (connection && fromCahce == false) {
      try {
        final remotePerson =
            await personRemoteDataSource.getCurrentPerson(email);
        localDataSource.personToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSource.getLastFromCache();
        return Right(localPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> setPerson(
    String email,
    String password,
    String nickName,
    String userName,
    String profileImagePath,
    String? description,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await personRemoteDataSource.setCurrentPerson(
          email,
          password,
          nickName,
          userName,
          profileImagePath,
          description,
        );
        final remotePerson =
            await personRemoteDataSource.getCurrentPerson(email);
        localDataSource.personToCache(remotePerson);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updatePerson(
    String email,
    String nickName,
    String userName,
    String? profileImagePath,
    String? description,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await personRemoteDataSource.updateCurrentPerson(
          email,
          nickName,
          userName,
          profileImagePath,
          description,
        );
        final remotePerson =
            await personRemoteDataSource.getCurrentPerson(email);
        localDataSource.personToCache(remotePerson);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePersons = await personRemoteDataSource.getAllPersons();
        return Right(remotePersons);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkSubscription(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final isSubscribed =
            await personRemoteDataSource.checkSubscription(email);
        return Right(isSubscribed);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> changeUserPhoto(File photo) async {
    if (await networkInfo.isConnected) {
      try {
        await personRemoteDataSource.changeUserPhoto(photo);
        return right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> getPersonsFromCollection(
    String firstCollectionName,
    String secondCollectionName,
    String docId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        return right(
          await personRemoteDataSource.getPersonsFromCollection(
            firstCollectionName,
            secondCollectionName,
            docId,
          ),
        );
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> subscribe(String userEmail) async {
    if (await networkInfo.isConnected) {
      try {
        await personRemoteDataSource.subscribe(userEmail);
        return right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unSubscribe(String userEmail) async {
    if (await networkInfo.isConnected) {
      try {
        await personRemoteDataSource.unSubscribe(userEmail);
        return right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
