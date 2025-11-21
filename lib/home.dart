import 'dart:async';
import 'package:flutter/material.dart';
// HAPUS import google_fonts biar ga error/ribet
import 'loker.dart';

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
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        // Menggunakan font default sistem (Roboto/San Francisco) yang rapi
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
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
    JobListPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        backgroundColor: Colors.white,
        elevation: 8,
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

// ================== HOME PAGE DENGAN BACKGROUND CIRCLE ANIMASI ==================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _bannerIndex = 0;
  late Timer _timer;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  final List<String> _banners = [
    'assets/images/banner_beasiswa.png',
    'assets/images/event_sarasehan.png',
    'assets/images/event_elektro.png',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _bannerIndex = (_bannerIndex + 1) % _banners.length;
        });
      }
    });

    // Setup animasi untuk circle background
    _animationController = AnimationController(
      duration: const Duration(seconds: 3), // Diperlambat dikit biar smooth
      vsync: this,
    )..repeat(reverse: true); // Biar animasinya loop (membesar-mengecil)

    _opacityAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // === BACKGROUND ANIMASI ===
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: [
                // Circle 1: Besar di kiri atas
                Positioned(
                  top: -screenHeight * 0.2,
                  left: -screenWidth * 0.3,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: screenWidth * 0.8,
                      height: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.shade100.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
                // Circle 2: Sedang di kanan atas
                Positioned(
                  top: screenHeight * 0.1,
                  right: -screenWidth * 0.2,
                  child: Opacity(
                    opacity: 0.5,
                    child: Transform.scale(
                      scale: _scaleAnimation.value * 0.9,
                      child: Container(
                        width: screenWidth * 0.4,
                        height: screenWidth * 0.4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade200.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        // === KONTEN UTAMA ===
        // Widget MATERIAL ini adalah KUNCI agar teks TIDAK KUNING
        Material(
          color: Colors
              .transparent, // Transparan biar background animasi kelihatan
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/User_Profile.jpg'),
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
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Selamat datang di IKA Polines!",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200, blurRadius: 5)
                            ]),
                        child: const Icon(Icons.notifications_none,
                            color: Colors.black),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // BANNER ATAS
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
                        errorBuilder: (c, e, s) => Container(
                          height: 160,
                          color: Colors.grey.shade200,
                          child: const Center(
                              child: Icon(Icons.image, color: Colors.grey)),
                        ),
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
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 290,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: [
                        _eventCard(
                          context,
                          'assets/images/event_sarasehan.png',
                          'Sarasehan Alumni',
                          '8 Oktober 2025',
                          'Kumpul bareng alumni.',
                          const EventPage(),
                        ),
                        _eventCard(
                          context,
                          'assets/images/event_elektro.png',
                          'Elektro Expo 2025',
                          '12 Oktober 2025',
                          'Ajang karya mahasiswa.',
                          const EventPage(),
                        ),
                        _eventCard(
                          context,
                          'assets/images/event_webinar.png',
                          'Webinar Karir',
                          '15 Oktober 2025',
                          'Tips jitu HRD.',
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

                  // BANTUAN SECTION
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
                    height: 210,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: [
                        _bantuanCard(
                          'assets/images/bantuan_mekah.png',
                          'Bantu Muslim ke Mekkah',
                          '0812-3456-7890',
                        ),
                        _bantuanCard(
                          'assets/images/bantuan_pelosok.png',
                          'Bantu warga pelosok',
                          '0812-3456-7891',
                        ),
                        _bantuanCard(
                          'assets/images/bantuan_anak.png',
                          'Bantu anak tersenyum',
                          '0812-3456-7892',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // LOKER SECTION
                  const Text(
                    "Loker Terbuka!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const JobListPage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF234F4D), Color(0xFF2A6E6B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF234F4D).withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Butuh lowongan kerja?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Cari sekarang di IKA Polines",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ],
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
                    'Gerakan solidaritas alumni.',
                  ),
                  _alumniCard(
                    'assets/images/ea_coffee.png',
                    'EA Coffee Shop',
                    'Bisnis kopi karya alumni.',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ],
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
  ) =>
      Container(
        width: 170,
        margin: const EdgeInsets.only(right: 14, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                img,
                height: 100,
                width: 146,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) =>
                    Container(height: 100, color: Colors.grey.shade200),
              ),
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
            Text(date,
                style: const TextStyle(fontSize: 12, color: Colors.teal)),
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
                child:
                    const Text("Selengkapnya", style: TextStyle(fontSize: 12)),
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
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Beasiswa Alumni Polines",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Bantuan biaya pendidikan bagi mahasiswa.",
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  _buildMetadataRow(Icons.person_outline, "25 Penerima"),
                  const SizedBox(height: 4),
                  _buildMetadataRow(
                    Icons.calendar_today_outlined,
                    "8 - 30 Oct 2025",
                  ),
                  const SizedBox(height: 4),
                  _buildMetadataRow(
                    Icons.apartment_outlined,
                    "Forum Alumni",
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
                errorBuilder: (c, e, s) =>
                    Container(width: 100, height: 100, color: Colors.grey),
              ),
            ),
          ],
        ),
      );

  static Widget _buildMetadataRow(IconData icon, String text) => Row(
        children: [
          Icon(icon, size: 16, color: Colors.black54),
          const SizedBox(width: 6),
          Text(text,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      );

  static Widget _bantuanCard(String img, String title, String contactPhone) =>
      Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12, bottom: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
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
                errorBuilder: (c, e, s) =>
                    Container(height: 90, color: Colors.grey),
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
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(img,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) =>
                      Container(width: 70, height: 70, color: Colors.grey)),
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
