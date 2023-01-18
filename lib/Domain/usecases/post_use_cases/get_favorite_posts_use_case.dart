import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/repositories/post_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class GetFavoritePostsUseCase
    extends UseCase<List<PostEntity>, GetFavoritePostsParams> {
  PostRepository postRepository;
  GetFavoritePostsUseCase(this.postRepository);

  @override
  Future<Either<Failure, List<PostEntity>>> call(
    GetFavoritePostsParams params,
  ) async {
    return await postRepository.getFavoritePosts(params.email);
  }
}

class GetFavoritePostsParams extends Equatable {
  final String email;

  const GetFavoritePostsParams({
    required this.email,
  });
  @override
  List<Object?> get props => [];
}
