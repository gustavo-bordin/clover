import 'package:flutter/material.dart';

import 'package:clover/common/constants.dart';

class TextSecondary extends StatelessWidget {
  final String text;

  const TextSecondary({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Roboto",
        fontSize: 14,
        color: ColorConstants.secondaryText,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
