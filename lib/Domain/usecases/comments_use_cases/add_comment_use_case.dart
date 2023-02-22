import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/repositories/comments_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class AddCommentUseCase extends UseCase<void, AddCommentParams> {
  CommentsRepository commentsRepository;
  AddCommentUseCase(this.commentsRepository);

  @override
  Future<Either<Failure, void>> call(AddCommentParams params) async {
    return await commentsRepository.addComment(
      params.post,
      params.text,
    );
  }
}

class AddCommentParams extends Equatable {
  final PostEntity post;
  final String text;

  const AddCommentParams(this.post, this.text);
  @override
  List<Object?> get props => [];
}
