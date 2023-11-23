import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final TextStyle textStyle;

  const TextWidget({
    super.key,
    required this.title,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle,
    );
  }
}
