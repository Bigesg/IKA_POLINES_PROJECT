import 'package:flutter/material.dart';
import 'job_detail.dart'; // pastikan file ini ada di folder lib/

void main() {
  runApp(const IkaPolinesApp());
}

class IkaPolinesApp extends StatelessWidget {
  const IkaPolinesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IKA POLINES',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF103C3F),
        scaffoldBackgroundColor: const Color(0xFF103C3F),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B2E30)),
        useMaterial3: true,
      ),
      home: const JobDetailPage(),
    );
  }
}
