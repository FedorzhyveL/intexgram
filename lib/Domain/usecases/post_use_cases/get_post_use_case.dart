import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/repositories/post_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class GetPostUseCase extends UseCase<PostEntity, GetPostParams> {
  PostRepository postRepository;
  GetPostUseCase(this.postRepository);

  @override
  Future<Either<Failure, PostEntity>> call(GetPostParams params) async {
    return await postRepository.getPost(
      params.postPath,
    );
  }
}

class GetPostParams extends Equatable {
  final String postPath;

  const GetPostParams({
    required this.postPath,
  });
  @override
  List<Object?> get props => [];
}
