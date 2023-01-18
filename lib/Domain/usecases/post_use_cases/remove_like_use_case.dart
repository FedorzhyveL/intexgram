import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/repositories/post_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class RemoveLikeUseCase extends UseCase<PostEntity, RemoveLikeParams> {
  PostRepository postRepository;
  RemoveLikeUseCase(this.postRepository);

  @override
  Future<Either<Failure, PostEntity>> call(RemoveLikeParams params) {
    return postRepository.removeLike(
      params.post,
    );
  }
}

class RemoveLikeParams extends Equatable {
  final PostEntity post;

  const RemoveLikeParams(this.post);
  @override
  List<Object?> get props => [];
}
