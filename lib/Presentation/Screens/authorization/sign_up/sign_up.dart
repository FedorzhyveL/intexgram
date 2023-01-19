import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Screens/authorization/sign_up/bloc/sign_up_bloc.dart';
import 'package:intexgram/Presentation/Screens/widgets/form_text_field.dart';
import 'package:intexgram/Presentation/Screens/authorization/Widgets/or_divider.dart';
import 'package:intexgram/Presentation/Screens/authorization/Widgets/sign_button.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

import 'bloc/sign_up_event.dart';
import 'bloc/sign_up_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nickNameController = TextEditingController();
  var userNameController = TextEditingController();

  late final SignUpBloc bloc;

  @override
  void initState() {
    bloc = SignUpBloc(serverLocator(), serverLocator());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  formLabel(),
                  signUpForm(),
                  const OrDivider(),
                  const SignButton(label: 'Sign in'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget formLabel() {
    return Text(
      "Intexgram",
      style: TextStyles.text.copyWith(
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget signUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormTextField(
            label: 'Email',
            controller: emailController,
            validation: (email) {
              String? message;
              bloc.validateEmail(email).then((value) => message = value);
              return message;
            },
          ),
          FormTextField(
            label: 'Password',
            controller: passwordController,
            validation: (password) {
              String? message;
              bloc.validatePassword(password).then((value) => message = value);
              return message;
            },
          ),
          FormTextField(
            label: 'Nick name',
            controller: nickNameController,
            validation: (nickName) {
              String? message;
              bloc.validateNickName(nickName).then((value) => message = value);
              return message;
            },
          ),
          FormTextField(
            label: 'User name',
            controller: userNameController,
            validation: (userName) => bloc.validateUserName(userName),
          ),
          MaterialButton(
            padding: const EdgeInsets.all(5),
            color: Palette.signButtonColor,
            child: const Text(
              'Sign up',
              style: TextStyles.signButtonText,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                bloc.add(
                  SignUp(
                    email: emailController.text,
                    password: passwordController.text,
                    userName: userNameController.text,
                    nickName: nickNameController.text,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
