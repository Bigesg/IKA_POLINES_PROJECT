import 'package:flutter/material.dart';
import 'Tentang_IKA.dart';
import 'chat_dengan_admin.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic>? user;
  const ProfilePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    const Color darkGreen = Color(0xFF163D39);
    const Color accentGold = Color(0xFFD4AF37);
    const Color lightGray = Color(0xFFF9FAFB);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        title: const Text('Profile', 
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          )
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: lightGray,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Profile Header Card dengan gradient
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [darkGreen, darkGreen.withOpacity(0.85)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: darkGreen.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Avatar dengan dekorasi
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.1),
                              border: Border.all(
                                color: accentGold,
                                width: 3,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.white.withOpacity(0.6),
                                size: 45,
                              ),
                            ),
                          ),
                          // Badge dengan aksen gold
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: accentGold,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.black87,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user != null ? (user!['nama_alumni'] ?? user!['nama_lengkap'] ?? 'Nama Alumni') : 'Sheva Zanuar',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: accentGold.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                user != null ? (user!['nomor_kta'] ?? user!['username'] ?? '202603001') : '202603001',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: accentGold,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Menu Section dengan card container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 12),
                      child: Text(
                        'Pengaturan Akun',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    // Menu Items dalam container
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildOptionItem(
                            context: context,
                            icon: Icons.chat_bubble_outline,
                            title: 'Chat dengan Admin',
                            subtitle: 'Hubungi tim support kami',
                            isFirst: true,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const ChatDenganAdminPage()),
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildOptionItem(
                            context: context,
                            icon: Icons.info_outline,
                            title: 'Tentang IKA Polines',
                            subtitle: 'Pelajari lebih lanjut tentang IKA',
                            isLast: true,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const TentangIKAPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        color: Colors.grey.withOpacity(0.15),
      ),
    );
  }

  static Widget _buildOptionItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    bool isFirst = false,
    bool isLast = false,
    required VoidCallback onTap,
  }) {
    const Color darkGreen = Color(0xFF163D39);
    const Color accentGold = Color(0xFFD4AF37);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? const Radius.circular(14) : Radius.zero,
          topRight: isFirst ? const Radius.circular(14) : Radius.zero,
          bottomLeft: isLast ? const Radius.circular(14) : Radius.zero,
          bottomRight: isLast ? const Radius.circular(14) : Radius.zero,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Icon Container dengan gradient background
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [darkGreen.withOpacity(0.1), accentGold.withOpacity(0.08)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: accentGold.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  icon,
                  color: darkGreen,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              // Title dan Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Arrow Icon
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.withOpacity(0.4),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

