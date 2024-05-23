import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:clover/common/constants.dart';

class TopUser extends StatelessWidget {
  final String name;
  final int leafs;
  final int position;
  final bool highlight;

  const TopUser({
    super.key,
    required this.name,
    this.highlight = false,
    required this.leafs,
    required this.position,
  });

  static Widget skeleton() {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 60,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: position == 1 ? ColorConstants.mainGreen : ColorConstants.mainGrey,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "                $name",
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Cabin",
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Row(
                children: [
                  Text(
                    leafs.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const FaIcon(
                    FontAwesomeIcons.leaf,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: position == 1 ? ColorConstants.secondaryGreen : const Color.fromRGBO(157, 157, 157, 1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(8),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: position == 1
                ? const FaIcon(
                    FontAwesomeIcons.trophy,
                    color: Colors.white,
                  )
                : Text(
                    position.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
