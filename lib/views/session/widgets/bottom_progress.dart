import 'package:flutter/material.dart';

import 'package:clover/common/constants.dart';

class Circle extends StatelessWidget {
  const Circle({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    double activeDotHeight = 20;
    double unactiveDotHeight = 20;

    double size = isActive ? activeDotHeight : unactiveDotHeight;
    Color color = isActive ? ColorConstants.mainGreen : ColorConstants.secondaryGreen;

    return Container(
      margin: const EdgeInsets.all(5),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class LoginProgress extends StatelessWidget {
  const LoginProgress({
    super.key,
    required this.pages,
    required this.currentPage,
  });

  final int pages;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pages,
            (index) => Circle(
              isActive: currentPage == index + 1,
            ),
          ),
        ),
      ),
    );
  }
}
