import 'package:flutter/material.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/locator_service.dart';

class SignButton extends StatelessWidget {
  const SignButton({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label == 'Sign up'
              ? "Don't have an account?"
              : "Already have an account?",
          style: const TextStyle(fontSize: 20),
        ),
        TextButton(
          onPressed: () {
            label == 'Sign up'
                ? serverLocator<FlutterRouter>().push(const SignUpPageRoute())
                : serverLocator<FlutterRouter>()
                    .replace(const SignInPageRoute());
          },
          child: Text(
            '$label.',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
