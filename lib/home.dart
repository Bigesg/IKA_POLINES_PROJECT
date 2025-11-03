import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Event'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Beasiswa'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Loker'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== Header =====
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/loker_ui.png'),
                      radius: 26,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Hi, Jerel",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Selamat datang kembali di IKA Polines App!",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.notifications_none, size: 28),
                  ],
                ),

                const SizedBox(height: 20),

                // ===== Banner =====
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/banner_beasiswa.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),

                const SizedBox(height: 24),

                // ===== Event =====
                const Text(
                  "Jangan Lewatkan !",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _eventCard(
                        'assets/images/event_sarasehan.png',
                        'SARASEHAN',
                        'Minggu, 8 Okt 2025',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _eventCard(
                        'assets/images/event_elektro.png',
                        'Elektro Expo 2025',
                        'Minggu, 8 Okt 2025',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ===== Beasiswa =====
                const Text(
                  "Raih Mimpimu dengan Beasiswa Ini!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _beasiswaCard(),

                const SizedBox(height: 28),

                // ===== Bantuan =====
                const Text(
                  "Bantuan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _bantuanCard('assets/images/bantuan_mekah.png',
                          'Bantu muslim Indonesia ke Mekkah'),
                      _bantuanCard('assets/images/bantuan_pelosok.png',
                          'Bantu warga pelosok makan siang'),
                      _bantuanCard('assets/images/bantuan_anak.png',
                          'Bantu anak-anak tersenyum'),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ===== Loker =====
                const Text(
                  "Loker Terbuka untuk Kamu!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                        child: _lokerCard(
                            'UI Designer', 'Invision', '3 hari lalu')),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _lokerCard(
                            'Digital Marketing', 'Telegram', '5 hari lalu')),
                  ],
                ),

                const SizedBox(height: 28),

                // ===== Alumni Sections =====
                _sectionCard("Dari Alumni untuk Alumni",
                    "Yuk, dukung produk dan layanan karya alumni Polines. Beli sambil bantu berkembang!"),
                const SizedBox(height: 16),
                _sectionCard("EA Coffee Shop",
                    "Cafe karya alumni Polines dengan cita rasa istimewa. Kunjungi dan rasakan pengalaman ngopi berbeda!"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===================== Widgets =====================

  static Widget _eventCard(String image, String title, String date) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(image, height: 110, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(date,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _beasiswaCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Beasiswa Alumni Polines Peduli (Need-Based)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 6),
                Text(
                  "Bantuan biaya pendidikan bagi mahasiswa aktif Polines yang membutuhkan dukungan finansial.",
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
                SizedBox(height: 8),
                Text(
                  "25 penerima • 8 Okt - 30 Okt 2025",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/beasiswa_alumni.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _bantuanCard(String image, String title) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(image, height: 100, fit: BoxFit.cover)),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  static Widget _lokerCard(String title, String company, String time) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(company,
              style: const TextStyle(color: Colors.teal, fontSize: 12)),
          const SizedBox(height: 4),
          Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ],
      ),
    );
  }

  static Widget _sectionCard(String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F2EE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 6),
          Text(desc, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
