import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';

part 'sign_up_state.freezed.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState.initial(
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController nickNameController,
    TextEditingController userNameController,
  ) = Initial;

  const factory SignUpState.succes(
    PersonEntity user,
  ) = Succes;
}
