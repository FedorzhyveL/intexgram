import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/entities/comment_entity.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/repositories/comments_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class GetCommentsUseCase
    extends UseCase<List<CommentEntity>, GetCommentsParams> {
  CommentsRepository commentsRepository;
  GetCommentsUseCase(this.commentsRepository);

  @override
  Future<Either<Failure, List<CommentEntity>>> call(
      GetCommentsParams params) async {
    return await commentsRepository.getComments(params.post);
  }
}

class GetCommentsParams extends Equatable {
  final PostEntity post;

  const GetCommentsParams(this.post);
  @override
  List<Object?> get props => [];
}
