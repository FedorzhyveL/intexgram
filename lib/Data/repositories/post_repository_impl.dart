import 'package:intexgram/Data/datasources/local_datasource.dart';
import 'package:intexgram/Data/datasources/post_remote_datasource.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:intexgram/Domain/repositories/post_repository.dart';
import 'package:intexgram/core/error/exceptions.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/platform/network_info.dart';

class PostRepositoryImpl extends PostRepository {
  final NetworkInfo networkInfo;
  final PostRemoteDataSource postRemoteDataSource;
  final LocalDataSource localDataSource;

  PostRepositoryImpl({
    required this.postRemoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PostEntity>> getPost(
    String postPath,
  ) async {
    bool connection = await networkInfo.isConnected;
    if (connection) {
      try {
        final remotePerson = await postRemoteDataSource.getPost(postPath);
        // localDataSource.personToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
      // try {
      //   final localPerson = await localDataSource.getLastFromCache();
      //   return Right(localPerson);
      // } on CacheException {
      //   return Left(CacheFailure());
      // }
    }
  }

  @override
  Future<Either<Failure, void>> createPost(
    String userEmail,
    String imagePath,
    String? description,
    DateTime creationTime,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await postRemoteDataSource.createPost(
          imagePath,
          userEmail,
          description,
          creationTime,
        );
        return right(null);
      } on ServerException {
        left(ServerFailure());
      }
    }
    return left(ServerFailure());
  }

  @override
  Future<Either<Failure, PostEntity>> addToFavorite(PostEntity post) async {
    if (await networkInfo.isConnected) {
      try {
        final updatedPost = await postRemoteDataSource.addToFavorite(post);
        right(updatedPost);
      } on ServerException {
        left(ServerFailure());
      }
    }
    return left(ServerFailure());
  }

  @override
  Future<Either<Failure, PostEntity>> removeFromFavorite(
      PostEntity post) async {
    if (await networkInfo.isConnected) {
      try {
        final updatedPost = await postRemoteDataSource.removeFromFavorite(post);
        right(updatedPost);
      } on ServerException {
        left(ServerFailure());
      }
    }
    return left(ServerFailure());
  }

  @override
  Future<Either<Failure, PostEntity>> removeLike(PostEntity post) async {
    if (await networkInfo.isConnected) {
      try {
        final updatedPost = await postRemoteDataSource.removeLike(post);
        right(updatedPost);
      } on ServerException {
        left(ServerFailure());
      }
    }
    return left(ServerFailure());
  }

  @override
  Future<Either<Failure, PostEntity>> setLike(PostEntity post) async {
    if (await networkInfo.isConnected) {
      try {
        final updatedPost = await postRemoteDataSource.setLike(post);
        right(updatedPost);
      } on ServerException {
        left(ServerFailure());
      }
    }
    return left(ServerFailure());
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getUserPosts(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await postRemoteDataSource.getUserPosts(email);
        return right(result);
      } on ServerException {
        left(ServerFailure());
      }
    }
    return left(ServerFailure());
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getFavoritePosts(
    String email,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await postRemoteDataSource.getFavoritePosts(email);
        return right(result);
      } on ServerException {
        left(ServerFailure());
      }
    }
    return left(ServerFailure());
  }
}
