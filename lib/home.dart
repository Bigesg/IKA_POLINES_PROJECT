import 'dart:async';
import 'package:flutter/material.dart';
import 'loker.dart'; // Navigasi ke halaman loker

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bannerIndex = 0;
  late Timer _timer;

  final List<String> _banners = [
    'assets/images/banner_beasiswa.png',
    'assets/images/event_sarasehan.png',
    'assets/images/event_elektro.png',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _bannerIndex = (_bannerIndex + 1) % _banners.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= HEADER =================
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile_ui.png'),
                  radius: 26,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Hi, Jerel",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("Selamat datang di IKA Polines App!",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.notifications_none, size: 28),
              ],
            ),

            const SizedBox(height: 18),

            // ================= BANNER OTOMATIS =================
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: Image.asset(
                  _banners[_bannerIndex],
                  key: ValueKey(_banners[_bannerIndex]),
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 22),

            // ================= EVENT SECTION =================
            const Text("Jangan Lewatkan!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 290,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _eventCard(
                    'assets/images/event_sarasehan.png',
                    'Sarasehan Alumni',
                    '8 Oktober 2025',
                    'Kumpul bareng alumni lintas angkatan.',
                  ),
                  _eventCard(
                    'assets/images/event_elektro.png',
                    'Elektro Expo 2025',
                    '12 Oktober 2025',
                    'Ajang karya mahasiswa & alumni elektro Polines.',
                  ),
                  _eventCard(
                    'assets/images/event_webinar.png',
                    'Webinar Karir: CV & Interview',
                    '15 Oktober 2025',
                    'Tips jitu dari praktisi HRD alumni Polines.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ================= LOKER SECTION (lebih kecil) =================
            const Text(
              "Loker Terbuka untuk Kamu!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const JobListPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B4D4B),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  shadowColor: Colors.black26,
                ),
                child: const Text(
                  "Klik di sini untuk informasi selengkapnya",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ================= DARI ALUMNI =================
            const Text("Dari Alumni untuk Alumni",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _alumniCard('assets/images/beasiswa_alumni.png', 'IKA Polines Care',
                'Gerakan solidaritas alumni Polines membantu sesama.'),
            _alumniCard('assets/images/ea_coffee.png', 'EA Coffee Shop',
                'Bisnis kopi karya alumni elektro Polines.'),
          ],
        ),
      ),
    );
  }

  // ==================== COMPONENTS ====================

  static Widget _eventCard(
      String img, String title, String date, String desc) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(img, height: 100, width: 146, fit: BoxFit.cover),
          ),
          const SizedBox(height: 10),
          Text(title,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(date, style: const TextStyle(fontSize: 12, color: Colors.teal)),
          const SizedBox(height: 4),
          Text(desc,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  static Widget _alumniCard(String img, String title, String desc) => Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
        ),
        child: Row(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  Image.asset(img, width: 70, height: 70, fit: BoxFit.cover)),
          const SizedBox(width: 14),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(desc,
                    style: const TextStyle(fontSize: 12, color: Colors.black87)),
              ]))
        ]),
      );
}
