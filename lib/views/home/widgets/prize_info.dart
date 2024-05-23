import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrizeInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget value;
  final Color color;

  const PrizeInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(width: 20),
        Row(
          children: [
            Text(
              "$label: ",
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w300,
                fontFamily: "Roboto",
              ),
            ),
            value
          ],
        ),
      ],
    );
  }
}
