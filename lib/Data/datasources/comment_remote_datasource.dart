import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intexgram/Data/models/comment_model.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_current_person_use_case.dart';
import 'package:intexgram/locator_service.dart';

abstract class CommentRemoteDataSource {
  Future<List<CommentModel>> getComments(
    PostEntity post,
  );

  Future<void> addComment(
    PostEntity post,
    String text,
  );
}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  @override
  Future<List<CommentModel>> getComments(PostEntity post) async {
    List<CommentModel> comments = [];
    await FirebaseFirestore.instance
        .collection("Posts")
        .doc(post.id)
        .collection("Comments")
        .get()
        .then(
      (value) async {
        for (var comment in value.docs) {
          GetCurrentPersonUseCase getCurrentPerson =
              GetCurrentPersonUseCase(serverLocator());
          final user = await getCurrentPerson(comment.get("user id"));
          Timestamp time = comment.get("creation time");
          comments.add(
            CommentModel(
              user: user,
              creationTime: DateTime.fromMillisecondsSinceEpoch(
                  time.millisecondsSinceEpoch),
              text: comment.get("text"),
              id: comment.get("id"),
            ),
          );
        }
      },
    );
    return comments;
  }

  @override
  Future<void> addComment(PostEntity post, String text) async {
    await FirebaseFirestore.instance
        .collection("Posts")
        .doc(post.id)
        .collection("Comments")
        .get()
        .then(
      (value) async {
        Map<String, dynamic> comment = {
          "user id": FirebaseAuth.instance.currentUser!.email,
          "creation time": Timestamp.now(),
          "text": text,
          "id": "comment ${value.size}",
        };
        await FirebaseFirestore.instance
            .collection("Posts")
            .doc(post.id)
            .collection("Comments")
            .doc("comment ${value.size}")
            .set(comment);
      },
    );
  }
}
