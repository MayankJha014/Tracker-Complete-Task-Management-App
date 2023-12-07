import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/core/contants/constants.dart';
import 'package:tracker/features/auth/screen/auth_screen.dart';
import 'package:tracker/features/auth/widget/text_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Sign Up",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    top: 30,
                  ),
                  child: Text(
                    "Create Account",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.7,
                  margin: const EdgeInsets.only(
                    left: 24,
                    top: 10,
                  ),
                  child: Text(
                    "Please Enter your Information and create your account",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Pallet.greyColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    left: 20,
                    right: 20,
                  ),
                  child: TextController(
                    labelText: "Name",
                    hintText: "Enter your name",
                    controller: nameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25.0,
                    left: 20,
                    right: 20,
                  ),
                  child: TextController(
                    labelText: "Email",
                    hintText: "Enter your email",
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25.0,
                    left: 20,
                    right: 20,
                  ),
                  child: TextController(
                    labelText: "Password",
                    hintText: "Enter your password",
                    controller: passwordController,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: size.width *
                        0.9, //width of button equal to parent widget
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Pallet.darkButtonColor),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: Text(
                      "Signin with",
                      style: GoogleFonts.poppins(
                        color: Pallet.greyColor,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Pallet.greyColor,
                      ),
                    ),
                    width: 60,
                    height: 55,
                    child: Image.asset(
                      "assets/google.png",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Have an Account?",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Pallet.greyColor,
                      ),
                      children: [
                        TextSpan(
                          text: "  Sign In",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Pallet.darkButtonColor,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const AuthScreen(),
                                ),
                              );
                            },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 80,
          right: 40,
          child: Image.asset(
            'assets/auth/Ellipse.png',
            scale: 2.0,
          ),
        )
      ],
    );
  }
}
