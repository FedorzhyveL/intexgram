import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/repositories/post_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class SetLikeUseCase extends UseCase<PostEntity, SetLikeParams> {
  PostRepository postRepository;
  SetLikeUseCase(this.postRepository);

  @override
  Future<Either<Failure, PostEntity>> call(SetLikeParams params) {
    return postRepository.setLike(
      params.post,
    );
  }
}

class SetLikeParams extends Equatable {
  final PostEntity post;

  const SetLikeParams(this.post);
  @override
  List<Object?> get props => [];
}
