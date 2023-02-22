import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../Domain/entities/person_entity.dart';

part 'list_of_users_state.freezed.dart';

@freezed
class ListOfUsersState with _$ListOfUsersState {
  const factory ListOfUsersState.initial(
    String docId,
    String label,
  ) = Initial;
  const factory ListOfUsersState.loaded(
    String docId,
    String label,
    List<PersonEntity> users,
  ) = Loaded;
}
