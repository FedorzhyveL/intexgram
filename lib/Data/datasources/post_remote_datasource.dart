import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intexgram/Data/models/post_model.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Domain/entities/post_entity.dart';
import 'package:intexgram/Domain/usecases/person_use_cases/get_current_person_use_case.dart';
import 'package:intexgram/locator_service.dart';

abstract class PostRemoteDataSource {
  Future<PostEntity> addToFavorite(
    PostEntity post,
  );

  Future<void> createPost(
    String filePath,
    String userEmail,
    String? description,
    DateTime creationTime,
  );

  Future<List<PostModel>> getFavoritePosts(
    String email,
  );

  Future<PostModel> getPost(
    String postId,
  );

  Future<List<PostModel>> getUserPosts(
    String email,
  );

  Future<PostEntity> removeFromFavorite(
    PostEntity post,
  );

  Future<PostEntity> removeLike(
    PostEntity post,
  );

  Future<PostEntity> setLike(
    PostEntity post,
  );
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  @override
  Future<void> createPost(
    String imagePath,
    String userEmail,
    String? description,
    DateTime creationTime,
  ) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userEmail)
        .collection("Posts")
        .get()
        .then(
      (value) {
        FirebaseFirestore.instance
            .collection("Posts")
            .doc("$userEmail ${value.size.toString()}")
            .set(
          {
            'user email': userEmail,
            'image path': imagePath,
            'description': description,
            'creation time': creationTime,
            'id': "$userEmail ${value.size.toString()}",
          },
        );
        FirebaseFirestore.instance
            .collection("Users")
            .doc(userEmail)
            .collection("Posts")
            .doc(value.size.toString())
            .set(
          {
            'id': "$userEmail ${value.size.toString()}",
            'creation time': creationTime,
          },
        );
      },
    );
  }

  @override
  Future<PostModel> getPost(String postId) async {
    late Timestamp creationTime;
    String description = '';
    String imagePath = '';
    String realPostId = '';
    late PersonEntity owner;
    int likes = 0;
    bool isLiked = false;
    bool isFavorite = false;

    await FirebaseFirestore.instance.collection("Posts").doc(postId).get().then(
      (post) async {
        imagePath = await FirebaseStorage.instance
            .ref()
            .child(post.get("image path"))
            .getDownloadURL();

        GetCurrentPersonUseCase getCurrentPerson =
            GetCurrentPersonUseCase(serverLocator());
        final failureOrPerson = await getCurrentPerson(GetCurrentPersonParams(
            email: post.get("user email"), fromCache: false));
        failureOrPerson.fold(
          (l) => null,
          (user) {
            owner = user;
          },
        );

        await FirebaseFirestore.instance
            .collection("Posts")
            .doc(post.id)
            .collection("Likes")
            .get()
            .then(
          (value) {
            {
              likes = value.size;
              for (var doc in value.docs) {
                if (doc.id == FirebaseAuth.instance.currentUser!.email) {
                  isLiked = true;
                  return;
                }
              }
            }
          },
        );
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("Favorite posts")
            .doc(post.id)
            .get()
            .then(
          (value) {
            if (value.exists) {
              isFavorite = true;
              return;
            }
          },
        );
        creationTime = post.get("creation time");
        description = post.get("description");
        realPostId = post.get("id");
      },
    );
    return PostModel(
      creationTime: DateTime.fromMillisecondsSinceEpoch(
          creationTime.millisecondsSinceEpoch),
      description: description,
      imagePath: imagePath,
      id: realPostId,
      isFavorite: isFavorite,
      isLiked: isLiked,
      likes: likes,
      owner: owner,
    );
  }

  @override
  Future<PostEntity> addToFavorite(PostEntity post) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("Favorite posts")
          .doc(post.id)
          .set(
        {
          "id": post.id,
        },
      );
    } catch (e) {
      return post;
    }
    post.isFavorite = true;
    return post;
  }

  @override
  Future<PostEntity> removeFromFavorite(PostEntity post) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("Favorite posts")
          .doc(post.id)
          .delete();
    } catch (e) {
      return post;
    }
    post.isFavorite = false;
    return post;
  }

  @override
  Future<PostEntity> removeLike(PostEntity post) async {
    try {
      await FirebaseFirestore.instance
          .collection("Posts")
          .doc(post.id)
          .collection("Likes")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .delete();
    } catch (e) {
      return post;
    }
    post.isLiked = false;
    return post;
  }

  @override
  Future<PostEntity> setLike(PostEntity post) async {
    try {
      await FirebaseFirestore.instance
          .collection("Posts")
          .doc(post.id)
          .collection("Likes")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .set(
        {
          "id": FirebaseAuth.instance.currentUser!.email,
        },
      );
    } catch (e) {
      return post;
    }
    post.isLiked = true;
    return post;
  }

  @override
  Future<List<PostModel>> getUserPosts(String email) async {
    List<PostModel> userPosts = [];
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("Posts")
        .orderBy("creation time", descending: true)
        .get()
        .then(
      (value) async {
        for (var postId in value.docs) {
          userPosts.add(await getPost(postId.get("id")));
        }
      },
    );
    return userPosts;
  }

  @override
  Future<List<PostModel>> getFavoritePosts(String email) async {
    List<PostModel> posts = [];
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("Favorite posts")
        .get()
        .then(
      (value) async {
        for (var doc in value.docs) {
          posts.add(await getPost(doc.get("id")));
        }
      },
    );
    return posts;
  }
}
