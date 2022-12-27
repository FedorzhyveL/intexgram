import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intexgram/Data/models/person_model.dart';

abstract class PersonRemoteDataSource {
  Future<PersonModel> getCurrentPerson(String email);
  Future<void> setCurrentPerson(
      String email, String password, String nickName, String userName);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  @override
  Future<PersonModel> getCurrentPerson(String email) async {
    Map<String, dynamic> user = {
      "Email": '',
      "Password": '',
      "Nick Name": '',
      "User Name": '',
    };
    await FirebaseFirestore.instance.collection("Users").get().then(
      (event) {
        for (var doc in event.docs) {
          if (doc.get("Email") == email) {
            user = {
              "Email": doc.get("Email").toString(),
              "Password": doc.get("Password").toString(),
              "Nick Name": doc.get("Nick Name").toString(),
              "User Name": doc.get("User Name").toString()
            };
          }
        }
      },
    );
    return PersonModel.fromDataBase(user);
  }

  @override
  Future<void> setCurrentPerson(
      String email, String password, String nickName, String userName) {
    final fireUser = <String, dynamic>{
      "Email": email,
      "Password": password,
      "Nick Name": nickName,
      "User Name": userName
    };
    return FirebaseFirestore.instance.collection("Users").add(fireUser);
  }
}
