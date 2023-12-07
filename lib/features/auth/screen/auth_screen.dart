import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/core/contants/constants.dart';
import 'package:tracker/features/auth/controller/auth_controller.dart';
import 'package:tracker/features/auth/screen/signup_screen.dart';
import 'package:tracker/features/auth/widget/text_controller.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Sign In",
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  top: 30,
                ),
                child: Text(
                  "Welcome Back",
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
                  "Please Enter your email address and password for Login",
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width:
                      size.width * 0.9, //width of button equal to parent widget
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
                      "Sign In",
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
                child: GestureDetector(
                  onTap: () => ref
                      .read(authControllerProvider.notifier)
                      .signWithGoogle(context),
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
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Not Registered Yet?",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Pallet.greyColor,
                    ),
                    children: [
                      TextSpan(
                        text: "  Sign Up",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Pallet.darkButtonColor,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SignUpScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
