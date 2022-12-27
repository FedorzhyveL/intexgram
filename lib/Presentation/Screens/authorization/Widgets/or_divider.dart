import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 60,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 1.0,
                  color: Colors.black,
                ),
              ),
            ),
            const Text(
              'or',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 1.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 60,
        ),
      ],
    );
  }
}
