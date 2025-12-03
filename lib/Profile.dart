import 'package:flutter/material.dart';
import 'Tentang_IKA.dart';
import 'Ganti_Kata_Sandi.dart';
import 'chat_dengan_admin.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color darkGreen = Color(0xFF163D39);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                // Profile card dengan gambar dan nama
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card image dengan wavy bottom - Placeholder kosong
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 100,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                          ),
                          // Wavy decoration at bottom
                          Positioned(
                            bottom: -8,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4AF37),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          // Black bar under wave
                          Positioned(
                            bottom: -20,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      // Name and ID
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Bagas Prasetyo',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'IKA-POLINES-YY-XXXXXX',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Three dots menu
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.more_vert,
                          color: Colors.black54,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Option list
                _buildOptionItem(
                  context: context,
                  icon: Icons.shield_outlined,
                  title: 'Ganti Kata Sandi',
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => const GantiKataSandiPage(),
                    );
                  },
                ),
                const Divider(height: 1, indent: 56),
                _buildOptionItem(
                  context: context,
                  icon: Icons.article_outlined,
                  title: 'Chat dengan Admin',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ChatDenganAdminPage()),
                    );
                  },
                ),
                const Divider(height: 1, indent: 56),
                _buildOptionItem(
                  context: context,
                  icon: Icons.language_outlined,
                  title: 'Tentang IKA Polines',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TentangIKAPage()),
                    );
                  },
                ),

                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildOptionItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.black54, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937))),
      onTap: onTap,
    );
  }
}
