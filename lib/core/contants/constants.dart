import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProfider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class Pallet {
  static const darkButtonColor =
      Color(0xff3580FF); // Second `const` is optional in assignments.
  static const darkThemeColor =
      Color(0xff0A0C16); // Second `const` is optional in assignments.
  static const lightButtonColor =
      Color(0xff756EF3); // Second `const` is optional in assignments.
  static const lightThemeColor =
      Color(0xffFFFFFF); // Second `const` is optional in assignments.

  static const greyColor = Color(0xff868D95);

  static const avatarPic =
      'https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg';

  static var darkModeAppTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xff0A0C16),
      buttonTheme: const ButtonThemeData(buttonColor: darkButtonColor),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
      ));
  static var lightModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xffFFFFFF),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    buttonTheme: const ButtonThemeData(buttonColor: lightButtonColor),
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ThemeNotifier({ThemeMode mode = ThemeMode.dark})
      : _mode = mode,
        super(
          Pallet.darkModeAppTheme,
        ) {
    getTheme();
  }

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = Pallet.lightModeAppTheme;
    } else {
      _mode = ThemeMode.dark;
      state = Pallet.darkModeAppTheme;
    }
  }

  ThemeMode get mode => _mode;

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = Pallet.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = Pallet.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
