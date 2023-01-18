import 'package:intexgram/Data/datasources/comment_remote_datasource.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/entities/comment_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:intexgram/Domain/repositories/comments_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/platform/network_info.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentRemoteDataSource commentRemoteDataSource;
  final NetworkInfo networkInfo;

  CommentsRepositoryImpl({
    required this.commentRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(
    PostEntity post,
  ) async {
    if (await networkInfo.isConnected) {
      final comments = await commentRemoteDataSource.getComments(post);
      return right(comments);
    } else {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addComment(
    PostEntity post,
    String text,
  ) async {
    if (await networkInfo.isConnected) {
      await commentRemoteDataSource.addComment(post, text);
      return right(null);
    } else {
      return left(ServerFailure());
    }
  }
}
