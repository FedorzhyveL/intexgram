import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_of_users_event.freezed.dart';

@freezed
class ListOfUsersEvent with _$ListOfUsersEvent {
  const factory ListOfUsersEvent.loadUsers(
    String docId,
    String labal,
  ) = LoadUsers;
}
