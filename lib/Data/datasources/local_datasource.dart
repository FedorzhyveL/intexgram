import 'dart:convert';

import 'package:intexgram/Data/models/person_model.dart';
import 'package:intexgram/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<PersonModel> getLastFromCache();
  Future<void> personToCache(PersonModel user);
}

const cachedPerson = 'CACHED_PERSON';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<PersonModel> getLastFromCache() async {
    final String? person = sharedPreferences.getString(cachedPerson);
    if (person!.isNotEmpty) {
      return Future.value(PersonModel.fromDataBase(json.decode(person)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personToCache(PersonModel user) {
    final String person = json.encode(user);
    sharedPreferences.setString(cachedPerson, person);
    return Future.value();
  }
}
