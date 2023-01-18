import 'package:dartz/dartz.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/core/error/failure.dart';

abstract class PostRepository {
  Future<Either<Failure, PostEntity>> getPost(
    String postPath,
  );

  Future<Either<Failure, List<PostEntity>>> getUserPosts(
    String email,
  );

  Future<Either<Failure, List<PostEntity>>> getFavoritePosts(
    String email,
  );

  Future<Either<Failure, void>> createPost(
    String userEmail,
    String imagePath,
    String? description,
    DateTime creationTime,
  );

  Future<Either<Failure, PostEntity>> addToFavorite(
    PostEntity post,
  );

  Future<Either<Failure, PostEntity>> removeFromFavorite(
    PostEntity post,
  );

  Future<Either<Failure, PostEntity>> setLike(
    PostEntity post,
  );

  Future<Either<Failure, PostEntity>> removeLike(
    PostEntity post,
  );
}
