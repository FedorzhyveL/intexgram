import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intexgram/Data/models/person_model.dart';
import 'package:path/path.dart';

abstract class PersonRemoteDataSource {
  Future<PersonModel> getCurrentPerson(
    String email,
  );

  Future<void> setCurrentPerson(
    String email,
    String password,
    String nickName,
    String userName,
    String profileImagePath,
    String? description,
  );

  Future<void> updateCurrentPerson(
    String email,
    String nickName,
    String userName,
    String? profileImagePath,
    String? description,
  );

  Future<List<PersonModel>> getAllPersons();

  Future<bool> checkSubscription(
    String email,
  );

  Future<List<PersonModel>> getPersonsFromCollection(
    String firstCollectionName,
    String secondCollectionName,
    String docId,
  );

  Future<void> unSubscribe(String userEmail);

  Future<void> subscribe(String userEmail);

  Future<void> changeUserPhoto(File photo);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  @override
  Future<PersonModel> getCurrentPerson(String email) async {
    Map<String, dynamic> user = {
      "Email": '',
      "Nick Name": '',
      "User Name": '',
      "Photo": '',
      "Description": '',
      "Followers": '',
      "Following": '',
      "Posts": '',
    };
    int followers = 0;
    int following = 0;
    int posts = 0;
    await FirebaseFirestore.instance.collection("Users").doc(email).get().then(
      (doc) async {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(email)
            .collection("Followers")
            .get()
            .then((value) => followers = value.size);
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(email)
            .collection("Following")
            .get()
            .then((value) => following = value.size);
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(email)
            .collection("Posts")
            .get()
            .then((value) => posts = value.size);

        user = {
          "Email": doc.get("Email"),
          "Nick Name": doc.get("Nick Name"),
          "User Name": doc.get("User Name"),
          "Photo": await FirebaseStorage.instance
              .ref()
              .child(doc.get("Photo"))
              .getDownloadURL(),
          "Description": doc.get("Description"),
          "Followers": followers,
          "Following": following,
          "Posts": posts,
        };
      },
    );
    return PersonModel.fromDataBase(user);
  }

  @override
  Future<void> setCurrentPerson(
    String email,
    String password,
    String nickName,
    String userName,
    String photo,
    String? description,
  ) {
    final fireUser = <String, dynamic>{
      "Email": email,
      "Password": password,
      "Nick Name": nickName,
      "User Name": userName,
      "Photo": photo,
      "Description": description,
      "Followers": 0,
      "Following": 0,
      "Posts": 0,
    };
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .set(fireUser);
  }

  @override
  Future<void> updateCurrentPerson(
    String email,
    String nickName,
    String userName,
    String? profileImagePath,
    String? description,
  ) {
    final fireUser = <String, dynamic>{
      "Nick Name": nickName,
      "User Name": userName,
      if (profileImagePath != null) "Photo": profileImagePath,
      "Description": description,
    };
    return FirebaseFirestore.instance.collection("Users").doc(email).set(
          fireUser,
          SetOptions(merge: true),
        );
  }

  @override
  Future<List<PersonModel>> getAllPersons() async {
    List<PersonModel> users = [];
    await FirebaseFirestore.instance.collection("Users").get().then(
      (value) async {
        for (var doc in value.docs) {
          if (doc.get("Email") != FirebaseAuth.instance.currentUser!.email) {
            users.add(
              await getCurrentPerson(doc.get("Email")),
            );
          }
        }
      },
    );
    return users;
  }

  @override
  Future<bool> checkSubscription(String email) async {
    bool isSubscribed = false;
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("Following")
          .doc(email)
          .get()
          .then(
        (value) {
          if (value.exists) {
            isSubscribed = true;
          }
        },
      );
    } catch (e) {
      isSubscribed = false;
    }
    return isSubscribed;
  }

  @override
  Future<List<PersonModel>> getPersonsFromCollection(
    String firstCollectionName,
    String secondCollectionName,
    String docId,
  ) async {
    List<PersonModel> users = [];
    await FirebaseFirestore.instance
        .collection(firstCollectionName)
        .doc(docId)
        .collection(secondCollectionName)
        .get()
        .then(
      (value) async {
        for (var doc in value.docs) {
          users.add(await getCurrentPerson(doc.id));
        }
      },
    );
    return users;
  }

  @override
  Future<void> subscribe(String userEmail) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userEmail)
        .collection("Followers")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set({"id": FirebaseAuth.instance.currentUser!.email});

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("Following")
        .doc(userEmail)
        .set({"id": userEmail});
  }

  @override
  Future<void> unSubscribe(String userEmail) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userEmail)
        .collection("Followers")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .delete();

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("Following")
        .doc(userEmail)
        .delete();
  }

  @override
  Future<void> changeUserPhoto(File photo) async {
    await FirebaseStorage.instance
        .ref("images/${basename(photo.path)}")
        .putFile(photo);

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then(
      (value) async {
        if (value.get("Photo") != "default/default_profile_image.png") {
          await FirebaseStorage.instance
              .ref()
              .child(value.get("Photo"))
              .delete();
        }
      },
    );
  }
}
