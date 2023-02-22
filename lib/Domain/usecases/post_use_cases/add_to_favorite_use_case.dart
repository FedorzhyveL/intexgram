import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/repositories/post_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class AddToFavoriteUseCase extends UseCase<PostEntity, AddToFavoriteParams> {
  PostRepository postRepository;
  AddToFavoriteUseCase(this.postRepository);

  @override
  Future<Either<Failure, PostEntity>> call(AddToFavoriteParams params) {
    return postRepository.addToFavorite(
      params.post,
    );
  }
}

class AddToFavoriteParams extends Equatable {
  final PostEntity post;

  const AddToFavoriteParams(this.post);
  @override
  List<Object?> get props => [];
}
