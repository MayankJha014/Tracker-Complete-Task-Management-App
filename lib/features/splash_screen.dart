import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker/core/bottom_bar.dart';
import 'package:tracker/core/contants/constants.dart';
import 'package:tracker/core/common/error_text.dart';
import 'package:tracker/core/common/loader.dart';
import 'package:tracker/features/auth/controller/auth_controller.dart';
import 'package:tracker/features/auth/screen/auth_screen.dart';
import 'package:tracker/features/intro/first_page.dart';
import 'package:tracker/model/user_model.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  UserModel? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;

    ref.watch(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  int count = 0;

  void navigateToHome() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? pageView = prefs.getBool('intro');

    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => pageView ?? false
              ? (userModel != null ? const BottomBar() : const AuthScreen())
              : const FirstPage(),
        ),
      ),
    );
  }

  void navigateToIntro() async {
    if (mounted) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? pageView = prefs.getBool('intro');
      pageView ?? false
          ? Future.delayed(
              const Duration(seconds: 2),
              () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const AuthScreen(),
                    ),
                  ))
          : Future.delayed(
              const Duration(seconds: 2),
              () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const FirstPage(),
                    ),
                  ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.darkButtonColor,
      body: ref.watch(authStateChangeProvider).when(
            data: (value) {
              if (value != null) {
                if (count < 2) {
                  getData(ref, value);
                }
                if (userModel != null) {
                  setState(() {
                    count++;
                  });
                  if (count < 2) {
                    navigateToHome();
                  }
                }
              } else {
                navigateToIntro();
              }
              return Center(
                child: Image.asset(
                  'assets/Logo.png',
                  scale: 1.3,
                ),
              );
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
