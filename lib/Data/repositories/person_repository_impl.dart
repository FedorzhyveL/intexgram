import 'package:intexgram/Data/datasources/person_local_datasource.dart';
import 'package:intexgram/Data/datasources/person_remote_datasource.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:intexgram/Domain/repositories/person_repository.dart';
import 'package:intexgram/core/error/exceptions.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/platform/network_info.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonLocalDataSource localDataSource;
  final PersonRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, PersonEntity>> getPerson(
      String email, bool fromCahce) async {
    bool connection = await networkInfo.isConnected;
    if (connection && fromCahce == false) {
      try {
        final remotePerson = await remoteDataSource.getCurrentPerson(email);
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
      String email, String password, String nickName, String userName) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.setCurrentPerson(
            email, password, nickName, userName);
        final remotePerson = await remoteDataSource.getCurrentPerson(email);
        localDataSource.personToCache(remotePerson);
        return const Right(true);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
