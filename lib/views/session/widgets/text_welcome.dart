import 'package:flutter/material.dart';

import 'package:clover/common/constants.dart';

class TextWelcome extends StatelessWidget {
  final String text;

  const TextWelcome({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 25,
        color: ColorConstants.mainWhite,
        fontFamily: 'Cabin',
      ),
      textAlign: TextAlign.left,
    );
  }
}
