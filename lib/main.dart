import 'package:flutter/material.dart';
import 'package:jokenpo2_teste/src/screen/jokenpo_home_page.dart';
import 'package:jokenpo2_teste/src/screen/splash_screen.dart';

void main() => runApp(const JokenpoGame());

class JokenpoGame extends StatelessWidget {
  const JokenpoGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokenpo Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: false,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/home': (_) => const JokenpoHomePage(),
      },
    );
  }
}
