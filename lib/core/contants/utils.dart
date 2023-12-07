import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
}
