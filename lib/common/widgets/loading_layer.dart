import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingLayer extends StatelessWidget {
  const LoadingLayer({super.key, required this.child, required this.isLoading});

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Material(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.white,
                size: 100,
              ),
            ),
          )
      ],
    );
  }
}
