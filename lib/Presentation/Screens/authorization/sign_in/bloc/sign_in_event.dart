import 'package:freezed_annotation/freezed_annotation.dart';

import 'sign_in_state.dart';

part 'sign_in_event.freezed.dart';

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.signIn(
    SignInState state,
  ) = SignIn;
}
