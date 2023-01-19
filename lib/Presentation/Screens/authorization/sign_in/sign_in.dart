import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Screens/authorization/sign_in/bloc/sign_in_bloc.dart';
import 'package:intexgram/Presentation/Screens/widgets/form_text_field.dart';
import 'package:intexgram/Presentation/Screens/authorization/Widgets/or_divider.dart';
import 'package:intexgram/Presentation/Screens/authorization/Widgets/sign_button.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';

import 'bloc/sign_in_event.dart';
import 'bloc/sign_in_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  late final SignInBloc bloc;
  @override
  void initState() {
    bloc = SignInBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  formLabel(),
                  logInForm(),
                  const OrDivider(),
                  const SignButton(label: 'Sign up'),
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

  Widget logInForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocConsumer<SignInBloc, SignInState>(
            builder: (context, state) {
              return Column(
                children: [
                  FormTextField(
                    label: 'Email',
                    controller: emailController,
                    validation: (email) {
                      String? message;
                      bloc
                          .validateEmail(email)
                          .then((value) => message = value);
                      return message;
                    },
                  ),
                  FormTextField(
                    label: 'Password',
                    controller: passwordController,
                    validation: (password) {
                      String? message;
                      bloc
                          .validatePassword(password)
                          .then((value) => message = value);
                      return message;
                    },
                  ),
                ],
              );
            },
            listener: (context, state) {
              // if (state is WrongEmail || state is WrongPassword) {
              //   _formKey.currentState!.reset();
              // }
            },
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Forgot password?',
                style: TextStyles.text.copyWith(
                  color: Palette.signTextColor,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          MaterialButton(
            padding: const EdgeInsets.all(5),
            color: Palette.signButtonColor,
            child: const Text(
              'Log in',
              style: TextStyles.signButtonText,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                bloc.add(
                  SignIn(
                    emailController.text,
                    passwordController.text,
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
