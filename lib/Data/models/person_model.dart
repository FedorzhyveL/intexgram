import 'package:intexgram/Domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  PersonModel({
    required nickName,
    required email,
    required userName,
    required profilePicturePath,
    required description,
    required followers,
    required following,
    required posts,
  }) : super(
          nickName: nickName,
          email: email,
          userName: userName,
          profilePicturePath: profilePicturePath,
          description: description,
          followers: followers,
          following: following,
          posts: posts,
        );

  Map toJson() {
    return {
      "Email": email,
      "Nick Name": nickName,
      "User Name": userName,
      "Photo": profilePicturePath,
      "Description": description,
      "Followers": followers,
      "Following": following,
      "Posts": posts,
    };
  }

  factory PersonModel.fromDataBase(Map<String, dynamic> user) {
    return PersonModel(
      email: user["Email"],
      nickName: user["Nick Name"],
      userName: user["User Name"],
      profilePicturePath: user["Photo"],
      description: user["Description"],
      followers: user["Followers"],
      following: user["Following"],
      posts: user["Posts"],
    );
  }
}
