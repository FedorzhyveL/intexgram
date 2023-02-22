import 'package:flutter/material.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Intexgram",
              style: TextStyles.text.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
            const Text(
              "Made by Intexsoft",
              style: TextStyles.text,
            ),
          ],
        ),
      ),
    );
  }
}
