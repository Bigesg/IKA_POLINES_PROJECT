import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IKA Polines Profile',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: screenWidth < 500 ? screenWidth : 400, //limit lebar
            child: Column(
        children: [
          // Header
          Container(
            color: const Color(0xFF143D40),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/User_Profile.jpg',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      //error gambar
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[400],
                              child: const Icon(Icons.person, size: 40, color: Colors.white),
                            );
                          },
                        ),
                      ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bagas Prasetyo',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'IKA-POLINES-YY-XXXXXX',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Garis putih
          Container(
            height: 3,
            color: Colors.white,
          ),

          // Daftar menu
          Expanded(
            child: Align(
              alignment: Aligment.topCenter,
              child: SizedBox(
                width: 360,
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: const [
                  ProfileMenuItem(
                    icon: Icons.security,
                    title: 'Ganti Kata Sandi',
                  ),
                  ProfileMenuItem(
                    icon: Icons.manage_accounts_outlined,
                    title: 'Pengaturan Akun',
                  ),
                  ProfileMenuItem(
                    icon: Icons.chat_bubble_outline,
                    title: 'Chat dengan Admin',
                  ),
                  ProfileMenuItem(
                    icon: Icons.public,
                    title: 'Tentang IKA Polines',
                  ),
                  ProfileMenuItem(
                    icon: Icons.notifications_none,
                    title: 'Notifikasi',
                  ),
                  ProfileMenuItem(
                    icon: Icons.info_outline,
                    title: 'Tentang Aplikasi',
                  ),
                 ],
                ),
               ),
              ),
             ),    
            ],
           ),
          ),
        ),
      ),    
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black87),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          onTap: () {},
        ),
        const Divider(height: 1),
      ],
    );
  }
}

