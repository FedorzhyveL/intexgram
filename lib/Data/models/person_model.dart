import 'package:intexgram/Domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  PersonModel({
    required nickName,
    required email,
    required password,
    required userName,
  }) : super(
          nickName: nickName,
          email: email,
          password: password,
          userName: userName,
        );

  Map<String, dynamic> toDataBase() {
    return {
      "Email": email,
      "Password": password,
      "Nick Name": nickName,
      "User Name": userName
    };
  }

  factory PersonModel.fromDataBase(Map<String, dynamic> user) {
    return PersonModel(
      email: user["Email"],
      nickName: user["Nick Name"],
      password: user["Password"],
      userName: user["User Name"],
    );
  }
}
