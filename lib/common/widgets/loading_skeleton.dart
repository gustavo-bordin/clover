import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class LoadingSkeleton extends StatelessWidget {
  final int amount;
  final Widget skeleton;

  const LoadingSkeleton({super.key, this.amount = 1, required this.skeleton});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 214, 214, 214),
        highlightColor: const Color.fromARGB(255, 186, 186, 186),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ...List.generate(
              amount,
              (index) {
                return Column(
                  children: [
                    skeleton,
                    if (index < amount - 1) const SizedBox(height: 5),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
