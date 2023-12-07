import 'package:flutter/material.dart';

class TextController extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  const TextController(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
          ),
          focusColor: const Color(0xff3580FF),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
