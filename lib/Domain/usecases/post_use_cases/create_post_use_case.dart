import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intexgram/Domain/repositories/post_repository.dart';
import 'package:intexgram/core/error/failure.dart';
import 'package:intexgram/core/usecases/use_case.dart';

class CreatePostUseCase extends UseCase<void, CreatePostParams> {
  PostRepository postRepository;
  CreatePostUseCase(this.postRepository);
  @override
  Future<Either<Failure, void>> call(CreatePostParams params) async {
    return await postRepository.createPost(
      params.userEmail,
      params.imagePath,
      params.description,
      params.creationTime,
    );
  }
}

class CreatePostParams extends Equatable {
  final String userEmail;
  final String imagePath;
  final String? description;
  final DateTime creationTime;

  const CreatePostParams({
    required this.userEmail,
    required this.imagePath,
    this.description,
    required this.creationTime,
  });
  @override
  List<Object?> get props => [];
}
