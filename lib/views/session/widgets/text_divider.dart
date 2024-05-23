import 'package:flutter/material.dart';

import 'package:clover/common/constants.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 2,
            color: ColorConstants.secondaryGrey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: TextStyle(
              color: ColorConstants.secondaryText,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 2,
            color: ColorConstants.secondaryGrey,
          ),
        ),
      ],
    );
  }
}
