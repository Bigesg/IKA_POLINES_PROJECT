import 'dart:async';
import 'package:flutter/material.dart';
import 'loker.dart'; // <<< PENTING: Pastikan file loker.dart ada

void main() {
  runApp(const MyApp());
}

// ================== ROOT APP ==================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const MainLayout(),
    );
  }
}

// ================== MAIN LAYOUT ==================
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    EventPage(),
    BeasiswaPage(),
    JobListPage(), // <<< Mengambil dari file loker.dart
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        backgroundColor: Colors.white,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Event'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Beasiswa'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Loker'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

// ================== HOME PAGE ==================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bannerIndex = 0;
  late Timer _timer;
  bool _isHovered = false;

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
            // HEADER
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
                    Text(
                      "Hi, Jerel",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Warna teks hitam
                      ),
                    ),
                    Text(
                      "Selamat datang di IKA Polines App!",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.notifications_none,
                  size: 28,
                  color: Colors.black,
                ),
              ],
            ),

            const SizedBox(height: 18),

            // BANNER
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

            // EVENT SECTION
            const Text(
              "Jangan Lewatkan!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ), // Warna teks hitam
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 290,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _eventCard(
                    context,
                    'assets/images/event_sarasehan.png',
                    'Sarasehan Alumni',
                    '8 Oktober 2025',
                    'Kumpul bareng alumni lintas angkatan.',
                    const EventPage(),
                  ),
                  _eventCard(
                    context,
                    'assets/images/event_elektro.png',
                    'Elektro Expo 2025',
                    '12 Oktober 2025',
                    'Ajang karya mahasiswa & alumni elektro Polines.',
                    const EventPage(),
                  ),
                  _eventCard(
                    context,
                    'assets/images/event_webinar.png',
                    'Webinar Karir: CV & Interview',
                    '15 Oktober 2025',
                    'Tips jitu dari praktisi HRD alumni Polines.',
                    const EventPage(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // BEASISWA SECTION
            const Text(
              "Beasiswa",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),

            _beasiswaCard(context),

            const SizedBox(height: 28),

            // BANTUAN SECTION (Dengan Kontak)
            const Text(
              "Bantuan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _bantuanCard(
                    'assets/images/bantuan_mekah.png',
                    'Bantu Muslim Indonesia ke Mekkah',
                    '0812-3456-7890',
                  ),
                  _bantuanCard(
                    'assets/images/bantuan_pelosok.png',
                    'Bantu warga pelosok untuk makan siang',
                    '0812-3456-7891',
                  ),
                  _bantuanCard(
                    'assets/images/bantuan_anak.png',
                    'Bantu anak-anak tersenyum',
                    '0812-3456-7892',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // LOKER SECTION (TOMBOL NAVIGASI)
            const Text(
              "Loker Terbuka untuk Kamu!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),

            MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  // Navigasi ke JobListPage yang ada di loker.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const JobListPage()),
                  );
                },
                child: AnimatedContainer(
                  width: double.infinity,
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? const Color(0xFF00695C)
                        : const Color(0xFF004D40),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Informasi selengkapnya, klik di sini",
                      style: TextStyle(
                        color: Colors.white, // Teks Putih
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ALUMNI SECTION
            const Text(
              "Dari Alumni untuk Alumni",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),

            _alumniCard(
              'assets/images/beasiswa_alumni.png',
              'IKA Polines Care',
              'Gerakan solidaritas alumni Polines membantu sesama.',
            ),
            _alumniCard(
              'assets/images/ea_coffee.png',
              'EA Coffee Shop',
              'Bisnis kopi karya alumni elektro Polines.',
            ),
          ],
        ),
      ),
    );
  }

  // === COMPONENTS ===

  static Widget _eventCard(
    BuildContext context,
    String img,
    String title,
    String date,
    String desc,
    Widget pageToNavigate,
  ) => Container(
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
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(date, style: const TextStyle(fontSize: 12, color: Colors.teal)),
        const SizedBox(height: 4),
        Text(
          desc,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF004D40),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => pageToNavigate),
              );
            },
            child: const Text("Selengkapnya", style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    ),
  );

  static Widget _beasiswaCard(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Beasiswa Alumni Polines Peduli (Need-Based)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Bantuan biaya pendidikan bagi mahasiswa aktif Polines yang membutuhkan dukungan finansial.",
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              _buildMetadataRow(Icons.person_outline, "25 Penerima"),
              const SizedBox(height: 4),
              _buildMetadataRow(
                Icons.calendar_today_outlined,
                "8 October - 30 October 2025",
              ),
              const SizedBox(height: 4),
              _buildMetadataRow(
                Icons.apartment_outlined,
                "Forum Alumni Polines",
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004D40),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BeasiswaPage()),
                  );
                },
                child: const Text("Detail", style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
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

  static Widget _buildMetadataRow(IconData icon, String text) => Row(
    children: [
      Icon(icon, size: 16, color: Colors.black54),
      const SizedBox(width: 6),
      Text(text, style: const TextStyle(fontSize: 12, color: Colors.black54)),
    ],
  );

  static Widget _bantuanCard(String img, String title, String contactPhone) =>
      Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                img,
                width: double.infinity,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.3,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            // Bagian Kontak
            Row(
              children: [
                Icon(
                  Icons.phone_outlined,
                  size: 14,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(width: 4),
                Text(
                  contactPhone,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  static Widget _alumniCard(String img, String title, String desc) => Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(img, width: 70, height: 70, fit: BoxFit.cover),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ================== HALAMAN TAMBAHAN ==================
class EventPage extends StatelessWidget {
  const EventPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Event")),
    body: const Center(child: Text("Halaman Event")),
  );
}

class BeasiswaPage extends StatelessWidget {
  const BeasiswaPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Beasiswa")),
    body: const Center(child: Text("Halaman Beasiswa")),
  );
}

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Profil")),
    body: const Center(child: Text("Halaman Profil")),
  );
}
