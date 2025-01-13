import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class WavyText extends StatelessWidget {
  const WavyText({
    required this.title,
    super.key,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        WavyAnimatedText(
          title,
          textStyle: context.general.textTheme.headlineLarge,
        ),
      ],
    );
  }
}
