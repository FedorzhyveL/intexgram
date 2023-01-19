import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../Domain/entities/person_entity.dart';

part 'search_page_state.freezed.dart';

@freezed
class SearchPageState with _$SearchPageState {
  const factory SearchPageState.initial() = Initial;

  const factory SearchPageState.loaded(
    List<PersonEntity> users,
  ) = Loaded;
}
