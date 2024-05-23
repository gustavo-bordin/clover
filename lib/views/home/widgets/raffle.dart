import 'package:flutter/material.dart';

class Raffle extends StatelessWidget {
  const Raffle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(8),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}
