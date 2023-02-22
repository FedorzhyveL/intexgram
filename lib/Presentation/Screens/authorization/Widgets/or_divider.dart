import 'package:flutter/material.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              color: Palette.orDividerColor,
            ),
          ),
        ),
        Text(
          'or',
          style: TextStyles.text,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              color: Palette.orDividerColor,
            ),
          ),
        ),
      ],
    );
  }
}
