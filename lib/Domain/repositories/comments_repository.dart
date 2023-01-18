import 'package:dartz/dartz.dart';
import 'package:intexgram/Domain/entities/comment_entity.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/core/error/failure.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<CommentEntity>>> getComments(
    PostEntity post,
  );

  Future<Either<Failure, void>> addComment(
    PostEntity post,
    String text,
  );
}
