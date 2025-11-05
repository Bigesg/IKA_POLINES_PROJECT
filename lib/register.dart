import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _ktaController = TextEditingController();
  final TextEditingController _tahunController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedJurusan;
  String? _selectedProdi;
  bool _obscurePassword = true;

  final Map<String, List<String>> _jurusanProdi = {
    'Administrasi Bisnis': [
      'Administrasi Bisnis — D3',
      'Manajemen Bisnis Internasional — D4',
      'Manajemen Pemasaran — D3',
      'Administrasi Bisnis Terapan — D4',
    ],
    'Akuntansi': [
      'Akuntansi — D3',
      'Keuangan dan Perbankan — D3',
      'Akuntansi Manajerial — D4',
      'Perbankan Syariah — D4',
      'Analisis Keuangan — D4',
      'Komputerasi Akuntansi — D4',
    ],
    'Teknik Elektro': [
      'Teknik Telekomunikasi — D3',
      'Teknik Elektronika — D3',
      'Teknik Listrik — D3',
      'Teknologi Rekayasa Elektronika — D4',
      'Teknologi Rekayasa Instalasi Listrik — D4',
    ],
    'Teknik Mesin': [
      'Teknik Mesin Produksi dan Perawatan — D3',
      'Teknologi Rekayasa Pembangkit Energi — D4',
      'Teknologi Rekayasa Manufaktur — D4',
    ],
    'Teknik Sipil': [
      'Teknik Perawatan dan Perbaikan Gedung — D3',
      'Teknologi Konstruksi Bangunan Gedung — D4',
      'Konstruksi Sipil — D4',
    ],
  };

  // ✅ Base URL inline ternary sesuai platform
  final String baseUrl = kIsWeb
      ? 'http://172.20.10.4:8000/api'
      : Platform.isAndroid
          ? 'http://10.0.2.2:8000/api'
          : Platform.isIOS
              ? 'http://localhost:8000/api'
              : 'http://172.20.10.4:8000/api';

  // ==============================
  // 🔁 Register Logic
  // ==============================
  void _register() async {
    if (_namaController.text.isEmpty ||
        _ktaController.text.isEmpty ||
        _selectedJurusan == null ||
        _selectedProdi == null ||
        _tahunController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua kolom wajib diisi!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nama_alumni': _namaController.text,
          'nomor_kta': _ktaController.text,
          'jurusan_alumni': _selectedJurusan!,
          'prodi_alumni': _selectedProdi!,
          'tahun_lulus': _tahunController.text,
          'username': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      final resData = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          resData['success'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterSuccessPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(resData['message'] ?? 'Gagal register'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // ==============================
  // 🎨 UI Build
  // ==============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCE5E1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black54),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const Text(
              "Daftar",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Daftar menggunakan akun alumni (KTA) Anda.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
            ),
            const SizedBox(height: 30),
            _buildInputField(controller: _namaController, icon: Icons.person_outline, hint: 'Nama Lengkap'),
            const SizedBox(height: 18),
            _buildInputField(controller: _ktaController, icon: Icons.badge_outlined, hint: 'Nomor KTA'),
            const SizedBox(height: 18),
            _buildDropdown(
              hint: 'Pilih Jurusan',
              icon: Icons.school_outlined,
              value: _selectedJurusan,
              items: _jurusanProdi.keys.toList(),
              onChanged: (val) {
                setState(() {
                  _selectedJurusan = val;
                  _selectedProdi = null;
                });
              },
            ),
            const SizedBox(height: 18),
            _buildDropdown(
              hint: 'Pilih Program Studi',
              icon: Icons.menu_book_outlined,
              value: _selectedProdi,
              items: _selectedJurusan != null ? _jurusanProdi[_selectedJurusan]! : [],
              onChanged: (val) => setState(() => _selectedProdi = val),
            ),
            const SizedBox(height: 18),
            _buildInputField(controller: _tahunController, icon: Icons.calendar_month, hint: 'Tahun Lulus', keyboardType: TextInputType.number),
            const SizedBox(height: 18),
            _buildInputField(controller: _usernameController, icon: Icons.account_circle_outlined, hint: 'Nama Pengguna'),
            const SizedBox(height: 18),
            _buildInputField(controller: _passwordController, icon: Icons.lock_outline, hint: 'Kata Sandi', isPassword: true),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F4F4F),
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("Daftar", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())),
              child: const Text(
                "Sudah punya akun? Masuk",
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🧩 Input Field Builder
  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.1), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: const Color(0xFF757575)),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF757575)),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                )
              : null,
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF757575)),
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Color(0xFF2F4F4F), width: 1)),
        ),
      ),
    );
  }

  // 🧩 Dropdown Builder
  Widget _buildDropdown({
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.1), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: const Color(0xFF757575)),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF757575)),
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Color(0xFF2F4F4F), width: 1)),
        ),
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF757575)),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

// ✅ Success Page
class RegisterSuccessPage extends StatelessWidget {
  const RegisterSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCE5E1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 20),
              const Text("Berhasil!", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text(
                "Akun Anda berhasil dibuat.\nSilakan login setelah diverifikasi admin.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 4, 61, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                ),
                child: const Text("Ke Halaman Login", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
