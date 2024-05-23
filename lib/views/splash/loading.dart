import 'package:flutter/material.dart';

import 'package:clover/common/constants.dart';

class LoadingSplash extends StatefulWidget {
  const LoadingSplash({super.key});

  @override
  State<StatefulWidget> createState() => _LoadingSplashState();
}

class _LoadingSplashState extends State<LoadingSplash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final double animationStart = 0;
  final double animationEnd = 1;
  final int animationDuration = 2000;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: animationDuration),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns: Tween(begin: animationStart, end: animationEnd).animate(_controller),
                  child: const Image(
                    image: AssetConstants.cloverOnlyLogoWhite,
                    width: 35,
                  ),
                ),
                const SizedBox(width: 15),
                const Image(
                  image: AssetConstants.cloverOnlyTextWhite,
                  width: 110,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
