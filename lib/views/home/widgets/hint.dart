import 'package:flutter/material.dart';

import 'package:clover/common/constants.dart';

class Hint extends StatelessWidget {
  final String text;

  const Hint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorConstants.secondaryGrey,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: ColorConstants.mainText,
        ),
      ),
    );
  }
}
