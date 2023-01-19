import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial(
    TextEditingController emailController,
    TextEditingController passwordController,
  ) = Initial;
  const factory SignInState.succes() = Succes;
}
