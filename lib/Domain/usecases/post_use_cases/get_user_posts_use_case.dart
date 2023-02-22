import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/repositories/post_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class GetUserPostsUseCase
    extends UseCase<List<PostEntity>, GetUserPostsParams> {
  PostRepository postRepository;
  GetUserPostsUseCase(this.postRepository);

  @override
  Future<Either<Failure, List<PostEntity>>> call(
    GetUserPostsParams params,
  ) async {
    return await postRepository.getUserPosts(
      params.email,
      params.limit,
      params.startAt,
    );
  }
}

class GetUserPostsParams extends Equatable {
  final String email;
  final int limit;
  final int startAt;

  const GetUserPostsParams({
    required this.limit,
    required this.email,
    this.startAt = 0,
  });
  @override
  List<Object?> get props => [];
}
