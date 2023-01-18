import 'package:intexgram/Domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({
    required owner,
    required imagePath,
    required description,
    required creationTime,
    required id,
    required likes,
    required isLiked,
    required isFavorite,
  }) : super(
          owner: owner,
          imagePath: imagePath,
          description: description,
          creationTime: creationTime,
          id: id,
          likes: likes,
          isLiked: isLiked,
          isFavorite: isFavorite,
        );
}
