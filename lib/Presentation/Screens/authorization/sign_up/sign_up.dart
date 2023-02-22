import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Screens/authorization/sign_up/bloc/sign_up_bloc.dart';
import 'package:intexgram/Presentation/Screens/widgets/form_text_field.dart';
import 'package:intexgram/Presentation/Screens/authorization/Widgets/or_divider.dart';
import 'package:intexgram/Presentation/Screens/authorization/Widgets/sign_button.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

import '../../../Routes/router.gr.dart';
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
    bloc = SignUpBloc(
      serverLocator(),
      serverLocator(),
      emailController,
      passwordController,
      nickNameController,
      userNameController,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) async {
          if (state is Succes) {
            await serverLocator<FlutterRouter>().replace<bool>(
              ProfileInformationRoute(
                user: state.user,
              ),
            );
            serverLocator<FlutterRouter>().replaceAll(
              [const MainScreenRoute()],
            );
          }
        },
        builder: (context, state) {
          return state.when(
            initial: (
              emailController,
              passwordController,
              nickNameController,
              userNameController,
            ) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      formLabel(),
                      signUpForm(state),
                      const OrDivider(),
                      const SignButton(label: 'Sign in'),
                    ],
                  ),
                ),
              );
            },
            succes: (user) => Container(),
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

  Widget signUpForm(SignUpState state) {
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
            password: true,
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
            color: Palette.signButtonColor,
            child: const Text(
              'Sign up',
              style: TextStyles.signButtonText,
            ),
            onPressed: () {
              bloc.add(SignUp(state));
            },
          ),
        ],
      ),
    );
  }
}
