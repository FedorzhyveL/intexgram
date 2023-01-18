import 'package:intexgram/Domain/entities/person_entity.dart';

class CommentEntity {
  PersonEntity user;
  DateTime creationTime;
  String text;
  String id;

  CommentEntity({
    required this.user,
    required this.creationTime,
    required this.text,
    required this.id,
  });
}
