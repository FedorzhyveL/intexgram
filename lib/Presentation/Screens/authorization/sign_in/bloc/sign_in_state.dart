import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial() = Initial;
  const factory SignInState.wrongPassword() = WrongPassword;
  const factory SignInState.wrongEmail() = WrongEmail;
  const factory SignInState.succes() = Succes;
}
