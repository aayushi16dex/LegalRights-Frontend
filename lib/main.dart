import 'package:flutter/material.dart';
import 'package:frontend/presentation/app_start/splash_screen.dart';
import 'package:frontend/core/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.initialize();
  // Set up the platform implementation for flutter_inappwebview
  WidgetsFlutterBinding.ensureInitialized();
  //InAppWebViewPlatform.instance = InAppWebViewPlatform();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: MaterialApp(
        title: 'Tiny Advocate',
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
