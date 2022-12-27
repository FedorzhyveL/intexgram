import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intexgram/Domain/entities/person_entity.dart';
import 'package:intexgram/Presentation/Screens/authorization/Widgets/form_text_field.dart';
import 'package:intexgram/Presentation/Screens/authorization/Widgets/or_divider.dart';
import 'package:intexgram/Presentation/Screens/authorization/Widgets/sign_button.dart';
import 'package:intexgram/Presentation/Screens/authorization/sign_up/cubit/sign_up_cubit.dart';
import 'package:intexgram/locator_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  PersonEntity user = PersonEntity();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nickNameController = TextEditingController();
  var userNameController = TextEditingController();
  late final SignUpCubit bloc;
  @override
  void initState() {
    bloc = SignUpCubit(serverLocator());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
  }

  Widget formLabel() {
    return const Text(
      "Intexgram",
      style: TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 20,
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
          ),
          FormTextField(
            label: 'Password',
            controller: passwordController,
          ),
          FormTextField(
            label: 'Nick name',
            controller: nickNameController,
          ),
          FormTextField(
            label: 'User name',
            controller: userNameController,
          ),
          MaterialButton(
            padding: const EdgeInsets.all(5),
            color: Colors.blue[300],
            child: const Text(
              'Sign up',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            onPressed: () {
              bloc.setUser(emailController.text, passwordController.text,
                  userNameController.text, nickNameController.text);
            },
          )
        ],
      ),
    );
  }
}
