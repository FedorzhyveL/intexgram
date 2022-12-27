import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Screens/authorization/Widgets/form_text_field.dart';
import 'package:intexgram/Presentation/Screens/authorization/Widgets/or_divider.dart';
import 'package:intexgram/Presentation/Screens/authorization/Widgets/sign_button.dart';
import 'package:intexgram/Presentation/Screens/authorization/sign_in/cubit/sign_in_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  late final SignInCubit bloc;
  @override
  void initState() {
    bloc = SignInCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<SignInCubit, SignInState>(
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
    return const Text(
      "Intexgram",
      style: TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 20,
      ),
    );
  }

  Widget logInForm() {
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
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () {},
              child: const Text('Forgot password?'),
            ),
          ),
          MaterialButton(
            padding: const EdgeInsets.all(5),
            color: Colors.blue[300],
            child: const Text(
              'Log in',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            onPressed: () {
              bloc.signIn(
                  emailController.text, passwordController.text, _formKey);
            },
          ),
        ],
      ),
    );
  }
}
