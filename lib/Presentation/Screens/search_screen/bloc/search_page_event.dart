import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../Domain/entities/person_entity.dart';

part 'search_page_event.freezed.dart';

@freezed
class SearchPageEvent with _$SearchPageEvent {
  const factory SearchPageEvent.getAllUsers() = GetAllUsers;

  const factory SearchPageEvent.updateList(
    List<PersonEntity> users,
  ) = UpdateList;
}
