import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';

class Stories extends StatelessWidget {
  final String imagePath;
  final String nickName;
  final Function onTap;
  const Stories({
    super.key,
    required this.imagePath,
    required this.nickName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => onTap()),
      child: Padding(
        padding: const EdgeInsets.only(left: 2.5, right: 2.5),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: CachedNetworkImageProvider(imagePath),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                nickName,
                style: TextStyles.text.copyWith(
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
