import 'package:intexgram/Domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    required user,
    required creationTime,
    required text,
    required id,
  }) : super(
          creationTime: creationTime,
          user: user,
          text: text,
          id: id,
        );
}
