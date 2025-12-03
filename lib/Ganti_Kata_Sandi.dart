import 'package:flutter/material.dart';

class GantiKataSandiPage extends StatefulWidget {
  const GantiKataSandiPage({super.key});

  @override
  State<GantiKataSandiPage> createState() => _GantiKataSandiPageState();
}

class _GantiKataSandiPageState extends State<GantiKataSandiPage> {
  final TextEditingController _passwordLamaController = TextEditingController();
  final TextEditingController _passwordBaruController = TextEditingController();
  final TextEditingController _passwordKonfirmasiController =
      TextEditingController();

  bool _showPasswordLama = false;
  bool _showPasswordBaru = false;
  bool _showPasswordKonfirmasi = false;

  @override
  void dispose() {
    _passwordLamaController.dispose();
    _passwordBaruController.dispose();
    _passwordKonfirmasiController.dispose();
    super.dispose();
  }

  void _closeModal() {
    Navigator.pop(context);
  }

  void _submitChangePassword() {
    // TODO: Implement password change logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password berhasil diubah')),
    );
    _closeModal();
  }

  @override
  Widget build(BuildContext context) {
    const Color darkGreen = Color(0xFF163D39);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: _closeModal,
        child: Stack(
          children: [
            // Dark overlay background
            Container(
              color: Colors.black.withOpacity(0.5),
            ),

            // Modal dialog - positioned at center
            Center(
              child: GestureDetector(
                onTap: () {
                  // Prevent closing when tapping inside the modal
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.shield_outlined,
                                  color: Colors.black54,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Ganti Kata Sandi',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Password Lama field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Password lama*',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: TextField(
                                  controller: _passwordLamaController,
                                  obscureText: !_showPasswordLama,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Masukkan password lama',
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade400,
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _showPasswordLama = !_showPasswordLama;
                                        });
                                      },
                                      child: Icon(
                                        _showPasswordLama
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey.shade400,
                                        size: 18,
                                      ),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Password Baru field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Password*',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: TextField(
                                  controller: _passwordBaruController,
                                  obscureText: !_showPasswordBaru,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Masukkan password baru',
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade400,
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _showPasswordBaru = !_showPasswordBaru;
                                        });
                                      },
                                      child: Icon(
                                        _showPasswordBaru
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey.shade400,
                                        size: 18,
                                      ),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Confirm Password field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Confirm new password*',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: TextField(
                                  controller: _passwordKonfirmasiController,
                                  obscureText: !_showPasswordKonfirmasi,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Konfirmasi password baru',
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade400,
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _showPasswordKonfirmasi =
                                              !_showPasswordKonfirmasi;
                                        });
                                      },
                                      child: Icon(
                                        _showPasswordKonfirmasi
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey.shade400,
                                        size: 18,
                                      ),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Cancel Button
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: _closeModal,
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text(
                                    'CANCEL',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Submit Button
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _submitChangePassword,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: darkGreen,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'SUBMIT',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
