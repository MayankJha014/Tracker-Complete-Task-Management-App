import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 20,
      ),
    );
  }
}
