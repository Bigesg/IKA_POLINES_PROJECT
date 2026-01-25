import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'background_decor.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

/// =============================================================
/// 1. STYLE KONSTANTA & DECORATION
/// =============================================================
const Color primaryColor = Color(0xFF2F4F4F);
const Color backgroundColor = Color(0xFFDCE5E1);
const Color hintColor = Color(0xFF757575);
const Color borderColor = Colors.black12;

InputDecoration customInputDecoration(String hint, IconData? icon) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: hintColor),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    prefixIcon: icon != null ? Icon(icon, color: primaryColor) : null,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: borderColor, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: primaryColor, width: 2),
    ),
  );
}

Widget _buildInputField({
  required TextEditingController controller,
  required String hint,
  IconData? icon,
  bool obscureText = false,
  Widget? suffixIcon,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black12.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Color(0xFF212121)),
      decoration: customInputDecoration(hint, icon).copyWith(
        suffixIcon: suffixIcon,
      ),
    ),
  );
}

/// =============================================================
/// 2. SPLASH SCREEN (ANIMASI LOGO)
/// =============================================================
class SplashWelcomePage extends StatefulWidget {
  const SplashWelcomePage({super.key});

  @override
  State<SplashWelcomePage> createState() => _SplashWelcomePageState();
}

class _SplashWelcomePageState extends State<SplashWelcomePage> {
  bool _isDotCenter = false;
  bool _isScaleCircle = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => _isDotCenter = true);

      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() => _isScaleCircle = true);

        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSplashAnimation(),
    );
  }

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
}

/// =============================================================
/// 3. LOGIN PAGE
/// =============================================================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _ktaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  // --- Fungsi Dialog Pop-up (DIPERBAIKI UNTUK MENGHILANGKAN UNDERLINE) ---
  void _showSuccessDialog() {
    showGeneralDialog(
      barrierDismissible: false,
      barrierColor: Colors.black38,
      context: context,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, anim, _, child) {
        return FadeTransition(
          opacity: anim,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: 320,
                      margin: const EdgeInsets.only(top: 45),
                      padding: const EdgeInsets.only(
                          top: 65, left: 20, right: 20, bottom: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Berhasil Masuk!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              decoration: TextDecoration.none, // FIXED: Menghilangkan underline
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Selamat datang kembali.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              decoration: TextDecoration.none, // FIXED: Menghilangkan underline
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.green,
                      child:
                          Icon(Icons.check, color: Colors.white, size: 48),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      barrierLabel: "Success dialog", // Added barrierLabel to fix the assertion error
    );

    // dialog stays visible; caller will close it and navigate as needed
  }

  void _showErrorDialog() {
    showGeneralDialog(
      barrierDismissible: true,
      barrierColor: Colors.black38,
      context: context,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, anim, _, child) {
        return FadeTransition(
          opacity: anim,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: 320,
                      margin: const EdgeInsets.only(top: 45),
                      padding: const EdgeInsets.only(
                          top: 65, left: 20, right: 20, bottom: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Akun tidak ditemukan",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              decoration: TextDecoration.none, // FIXED
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Silakan periksa kembali informasi akun Anda.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              decoration: TextDecoration.none, // FIXED
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.red,
                      child:
                          Icon(Icons.close, color: Colors.white, size: 48),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      barrierLabel: "Error dialog", // Added barrierLabel to fix the assertion error
    );
  }


  // --- Fungsi Utama Login ---
  Future<void> _login() async {
    final kta = _ktaController.text.trim();
    final password = _passwordController.text.trim();

    if (kta.isEmpty || password.isEmpty) {
      _showErrorDialog();
      return;
    }

    setState(() => _isLoading = true);
    try {
      final uri = Uri.parse('http://127.0.0.1:8000/api/login-alumni');
      final response = await http.post(uri, body: {
        'no_kta': kta,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _showSuccessDialog();
          // close dialog and navigate after a short delay so dialog is visible briefly
          Future.delayed(const Duration(milliseconds: 900), () {
            Navigator.pop(context); // close dialog
            Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(user: data['data']),
            ),
            (route) => false,
          );

          });
        } else {
          _showErrorDialog();
        }
      } else {
        _showErrorDialog();
      }
    } catch (e) {
      if (kDebugMode) print('Login error: $e');
      _showErrorDialog();
    } finally {
      setState(() => _isLoading = false);
    }
  }


  void _goToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
    );
  }

  Future<void> _openRegisterLink() async {
    final url = Uri.parse(
      "https://halimahadial.github.io/Register/",
    );
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BackgroundDecor(
        type: 'Bold',
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                const SizedBox(height: 80),

                const Text(
                  "Masuk",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212121),
                  ),
                ),

                const SizedBox(height: 10),
                const Text(
                  "Masuk menggunakan akun alumni (KTA) Anda.",
                  style: TextStyle(fontSize: 14, color: hintColor),
                ),

                const SizedBox(height: 60),

                _buildInputField(
                  controller: _ktaController,
                  icon: Icons.person_outline,
                  hint: 'Nomor KTA / Username',
                ),

                const SizedBox(height: 20),

                _buildInputField(
                  controller: _passwordController,
                  icon: Icons.lock_outline,
                  hint: 'Kata Sandi',
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: _goToForgotPassword,
                    child: const Text(
                      "Lupa Sandi?",
                      style: TextStyle(fontSize: 14, color: hintColor),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text(
                              "Masuk",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum punya akun?",
                        style: TextStyle(color: hintColor)),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: _openRegisterLink,
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// =============================================================
/// 4. FORGOT PASSWORD PAGE
/// =============================================================
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _ktaController = TextEditingController();

  void _contactAdmin() async {
    final kta = _ktaController.text.trim();

    if (kta.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mohon isi Nomor KTA / Username terlebih dahulu.")),
      );
      return;
    }

    final adminNumber = "6281226747714"; 
    final message = Uri.encodeComponent(
        "Halo Admin, saya ingin mengatur ulang kata sandi.\n"
        "NIM/KTA saya: $kta");

    final url = Uri.parse("https://wa.me/$adminNumber?text=$message");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal membuka WhatsApp.")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BackgroundDecor(
        type: 'Bold',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 40),

              const Text(
                "Lupa Kata\nSandi",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Masukkan Nomor KTA/Username Anda.\nKami akan membantu reset kata sandi via Admin.",
                style: TextStyle(fontSize: 14, color: hintColor),
              ),

              const SizedBox(height: 40),

              _buildInputField(
                controller: _ktaController,
                hint: "Nomor KTA / Username",
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _contactAdmin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Hubungi Admin via WhatsApp",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}