import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:clover/common/constants.dart';

enum BorderRadiusStyles {
  topLeftBottomRight,
  bottomRightBottomLeft,
}

extension BorderRadiusStyleExtension on BorderRadiusStyles {
  BorderRadius apply() {
    switch (this) {
      case BorderRadiusStyles.bottomRightBottomLeft:
        return const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        );

      case BorderRadiusStyles.topLeftBottomRight:
        return const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(8),
        );
    }
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onTap;
  final BorderRadius borderRadiusStyle;
  final Color color;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.borderRadiusStyle,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: borderRadiusStyle, color: color),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: ColorConstants.mainWhite,
                  fontSize: 16,
                  fontFamily: "Cabin",
                ),
              ),
              if (icon != null)
                FaIcon(
                  icon,
                  color: ColorConstants.mainWhite,
                )
            ],
          ),
        ),
      ),
    );
  }
}
