import 'package:flutter/material.dart';

import 'src/screen/jokenpo_home_page.dart';

void main() => runApp(const JokenpoGame());

class JokenpoGame extends StatelessWidget {
  const JokenpoGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokenpo Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true
      ),
      home: const JokenpoHomePage(),
    );
  }
}
