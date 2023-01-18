class PersonEntity {
  String email;
  String nickName;
  String userName;
  String profilePicturePath;
  String? description;
  int posts;
  int followers;
  int following;

  PersonEntity({
    required this.nickName,
    required this.email,
    required this.userName,
    required this.profilePicturePath,
    this.description,
    required this.followers,
    required this.following,
    required this.posts,
  });
}
