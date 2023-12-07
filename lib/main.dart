import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/core/contants/constants.dart';
import 'package:tracker/features/splash_screen.dart';
import 'package:tracker/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: Tracker()));
}

class Tracker extends ConsumerStatefulWidget {
  const Tracker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TrackerState();
}

class _TrackerState extends ConsumerState<Tracker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Tracker",
        theme: ref.watch(themeNotifierProfider),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen()
        // routerDelegate: RoutemasterDelegate(
        //   routesBuilder: (context) {
        //     return allRoute;
        //   },
        // ),
        // routeInformationParser: const RoutemasterParser(),
        );
  }
}
