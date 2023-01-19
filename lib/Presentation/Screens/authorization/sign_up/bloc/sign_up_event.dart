import 'package:freezed_annotation/freezed_annotation.dart';

import 'sign_up_state.dart';

part 'sign_up_event.freezed.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.signUp(
    SignUpState state,
  ) = SignUp;
}
