import 'package:flutter/material.dart';
// import 'home.dart'; // belum dibuat

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Alumni',
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _ktaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _login() {
    String kta = _ktaController.text.trim();
    String password = _passwordController.text.trim();

    if (kta.isNotEmpty && password.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const PlaceholderPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Nomor KTA dan kata sandi wajib diisi!"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCE5E1),
      body: Stack(
        children: [
          // ===========================
          // 🔵 BACKGROUND BLOBS
          // ===========================
          _buildBlob(top: -120, left: -80, size: 260, color: const Color(0xFF264B46)),
          _buildBlob(top: 200, right: -100, size: 240, color: const Color(0xFF91A6A3).withOpacity(0.3)),
          _buildBlob(bottom: -100, left: -80, size: 260, color: const Color(0xFF264B46).withOpacity(0.25)),
          _buildBlob(bottom: 40, right: 20, size: 80, color: const Color(0xFFDCE5E1)),

          // ===========================
          // 🧩 LOGIN FORM CONTENT
          // ===========================
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Masuk",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C2F2D),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Masuk menggunakan akun alumni (KTA) Anda.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Color(0xFF546E64)),
                  ),
                  const SizedBox(height: 50),

                  // Nomor KTA
                  _buildInputField(
                    controller: _ktaController,
                    icon: Icons.person_outline,
                    hint: 'Nomor KTA/NTM',
                  ),
                  const SizedBox(height: 20),

                  // Kata Sandi
                  _buildInputField(
                    controller: _passwordController,
                    icon: Icons.lock_outline,
                    hint: 'Kata Sandi',
                    isPassword: true,
                  ),
                  const SizedBox(height: 15),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Lupa Sandi?",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Tombol Masuk
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF264B46),
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(vertical: 15),
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔵 Custom Background Shape
  Widget _buildBlob({
    double? top,
    double? left,
    double? right,
    double? bottom,
    required double size,
    required Color color,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size * 0.6),
        ),
      ),
    );
  }

  // 🧱 Input Field Template
  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: const Color(0xFF757575)),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xFF757575),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                )
              : null,
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF757575)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFF264B46), width: 1),
          ),
        ),
      ),
    );
  }
}

// Temporary Placeholder Page
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Placeholder')),
      body: const Center(child: Text('HomePage belum dibuat')),
    );
  }
}
