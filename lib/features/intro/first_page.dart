import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker/core/contants/constants.dart';
import 'package:tracker/features/auth/screen/auth_screen.dart';
import 'package:tracker/features/intro/second_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/intro/1st_page.png',
                filterQuality: FilterQuality.high,
                isAntiAlias: true,
              ),
              SizedBox(
                width: size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Task Management",
                        style: TextStyle(
                          fontSize: 18,
                          color: Pallet.darkButtonColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Let's create a ",
                          style: GoogleFonts.poppins(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text: "Space",
                              style: TextStyle(
                                fontSize: 35,
                                color: Pallet.darkButtonColor,
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    'Poppins', // You may need to specify the font family here
                              ),
                            ),
                            TextSpan(
                              text: " for your workflow.",
                              style: GoogleFonts.poppins(
                                fontSize: 35,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset('assets/intro/1st_layer.png'),
        ),
        Positioned(
          bottom: 45,
          right: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const SecondPage(),
                ),
              );
            },
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 35,
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 20,
          child: GestureDetector(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setBool('intro', true);
              Navigator.of(context).pop(
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const AuthScreen(),
                  duration: const Duration(microseconds: 500),
                ),
              );
            },
            child: const Text(
              "Skip",
              style: TextStyle(
                color: Colors.white,
                inherit: false,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
