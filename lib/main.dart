import 'package:flutter/material.dart';
import 'welcomepage.dart';
import 'login.dart';
import 'register.dart';
import 'home.dart';

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
      initialRoute: '/welcome',

      // daftar rute (hapus job_detail karena butuh parameter)
      routes: {
        '/welcome': (context) => const SplashWelcomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
