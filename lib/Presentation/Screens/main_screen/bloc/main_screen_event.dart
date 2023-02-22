import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_screen_event.freezed.dart';

@freezed
class MainScreenEvent with _$MainScreenEvent {
  const factory MainScreenEvent.loadUser() = LoadUser;
}
