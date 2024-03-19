import 'package:flutter/material.dart';
import 'package:lixplor/screens/vanilla.dart';

void main() {
  runApp(const LixplorRoot());
}

class LixplorRoot extends StatelessWidget {
  const LixplorRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lixplor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
