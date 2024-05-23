import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:clover/common/constants.dart';

class TextTitle extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;

  const TextTitle({super.key, required this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          color: ColorConstants.mainGreen,
          width: 20,
          height: 5,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 20,
                  ),
                ),
                if (icon != null && onTap != null)
                  FaIcon(
                    icon,
                    color: ColorConstants.mainGrey,
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
