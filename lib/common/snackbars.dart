import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:clover/common/constants.dart';

SnackBar customSnackBar(Color color, IconData icon, String message) {
  return SnackBar(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color.fromARGB(0, 162, 153, 153),
    content: Container(
      padding: const EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              message,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

void clearSnackBars(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
}

void showSuccessSnackBar(BuildContext context, String message) {
  final snackbar = customSnackBar(
    ColorConstants.secondaryGreen,
    FontAwesomeIcons.faceSmile,
    message,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void showErrorSnackBar(BuildContext context, String message) {
  final snackbar = customSnackBar(
    Colors.red,
    FontAwesomeIcons.faceFrownOpen,
    message,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
