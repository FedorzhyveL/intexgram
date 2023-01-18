import 'package:flutter/material.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';

class ProfileButton extends StatelessWidget {
  final bool isVisible;
  final Function() onPressed;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  const ProfileButton({
    super.key,
    required this.isVisible,
    required this.onPressed,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Expanded(
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const Size(0, 25),
            side: const BorderSide(
              color: Palette.borderSideColor,
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyles.text.copyWith(
                  color: foregroundColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
