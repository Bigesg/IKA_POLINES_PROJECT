import 'package:flutter/material.dart';
import 'login.dart';
import 'background_decor.dart';
import 'register.dart';

void main() {
  runApp(const MyApp());
}

// 📌 Aplikasi Utama
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFDCE5E1),
      ),
      home: const SplashWelcomePage(),
    );
  }
}

// 📌 Splash Screen sebelum Welcome
class SplashWelcomePage extends StatefulWidget {
  const SplashWelcomePage({super.key});

  @override
  State<SplashWelcomePage> createState() => _SplashWelcomePageState();
}

class _SplashWelcomePageState extends State<SplashWelcomePage> {
  bool _isDotCenter = false;
  bool _isScaleCircle = false;
  bool _showWelcome = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => _isDotCenter = true);

      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() => _isScaleCircle = true);

        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() => _showWelcome = true);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (!_showWelcome)
            _buildSplashAnimation(),

          if (_showWelcome)
            _buildWelcomeScreen(context),
        ],
      ),
    );
  }

  // ✅ Animasi Splash yang rapi & center
  Widget _buildSplashAnimation() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedScale(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            scale: _isScaleCircle ? 10 : 1,
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),

          AnimatedAlign(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutBack,
            alignment:
                _isDotCenter ? Alignment.center : const Alignment(0.0, 0.6),
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),

          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: _isScaleCircle ? 1 : 0,
            child: Image.asset(
              'assets/images/Logo.png',
              width: 140,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Halaman Welcome clean
  Widget _buildWelcomeScreen(BuildContext context) {
    return BackgroundDecor(
      type: 'Bold',
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              const SizedBox(height: 30),

              Image.asset('assets/images/Logo.png', width: 150),
              const SizedBox(height: 40),

              const Text(
                "Selamat Datang",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),

              const SizedBox(height: 60),

              // ✅ Tombol Masuk
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F4F4F),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Masuk",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // ✅ Tombol Daftar
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterPage()),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFF2F4F4F),
                      width: 1.5,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Daftar",
                    style: TextStyle(fontSize: 18, color: Color(0xFF2F4F4F)),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
