import 'package:intexgram/Domain/entities/person_entity.dart';

class PostEntity {
  PersonEntity owner;
  String imagePath;
  String? description;
  DateTime creationTime;
  String id;
  int likes;
  bool isLiked;
  bool isFavorite;

  PostEntity({
    required this.owner,
    required this.imagePath,
    this.description,
    required this.creationTime,
    required this.id,
    required this.likes,
    required this.isLiked,
    required this.isFavorite,
  });
}
