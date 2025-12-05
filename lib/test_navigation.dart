import 'package:flutter/material.dart';
import 'navigator.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'IKA POLINES Navigation Test',
      home: MainAppNavigator(),
      debugShowCheckedModeBanner: false,
    );
  }
}
