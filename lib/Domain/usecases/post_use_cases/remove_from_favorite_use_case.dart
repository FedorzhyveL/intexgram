import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/repositories/post_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class RemoveFromFavoriteUseCase
    extends UseCase<PostEntity, RemoveFromFavoriteParams> {
  PostRepository postRepository;
  RemoveFromFavoriteUseCase(this.postRepository);

  @override
  Future<Either<Failure, PostEntity>> call(RemoveFromFavoriteParams params) {
    return postRepository.removeFromFavorite(
      params.post,
    );
  }
}

class RemoveFromFavoriteParams extends Equatable {
  final PostEntity post;

  const RemoveFromFavoriteParams(this.post);
  @override
  List<Object?> get props => [];
}
