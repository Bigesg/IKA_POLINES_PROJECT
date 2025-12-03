import 'package:flutter/material.dart';
import 'home.dart';
import 'eventdetail.dart';
import 'beasiswadetail.dart';
import 'donasidetail.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int selectedIndex = 0;

  final List<String> tabs = ["Berita", "Beasiswa", "Donasi"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: SafeArea(
        child: Column(
          children: [
            // ====================== HEADER ===========================
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo_polines.png',
                    height: 90,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "IKATAN ALUMNI\nPOLINES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
            ),

            // ====================== TABS ==============================
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(tabs.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? const Color(0xFF004E46)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),

            // ===================== CONTENT ============================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    if (selectedIndex == 0) _buildCardBerita(),
                    if (selectedIndex == 1) _buildCardBeasiswa(),
                    if (selectedIndex == 2) _buildCardDonasi(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ====================== BOTTOM NAV =============================
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // =========================================================
  //                       K A R T U   B E R I T A
  // =========================================================
  Widget _buildCardBerita() {
    return _eventCard(
      title: "Update Alumni Hari Ini",
      img: "assets/berita1.png",
      subtitle: "Updated today",
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EventDetailPage(
              title: "Update Alumni Hari Ini",
              content:
                  "Berita terbaru seputar kegiatan alumni Polines hari ini.",
              image: "assets/berita1.png",
              date: "Hari ini",
              location: "Polines, Semarang",
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  //                     K A R T U   B E A S I S W A
  // =========================================================
  Widget _buildCardBeasiswa() {
    return _eventCard(
      title: "Beasiswa Alumni Polines 2025",
      img: "assets/beasiswa_logo.png",
      subtitle: "Pendaftaran dibuka 8 - 30 Oktober 2025",
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BeasiswaDetailPage(
              title: "Beasiswa Alumni Polines 2025",
              content:
                  "Program beasiswa untuk mahasiswa berprestasi dan kurang mampu dari alumni Polines.",
              image: "assets/beasiswa_logo.png",
              date: "8 - 30 Oktober 2025",
              location: "Politeknik Negeri Semarang",
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  //                       K A R T U   D O N A S I
  // =========================================================
  Widget _buildCardDonasi() {
    return _eventCard(
      title: "Program Donasi Alumni Peduli",
      img: "assets/donasi.png",
      subtitle: "Open donation",
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DonasiDetailPage(
              title: "Program Donasi Alumni Peduli",
              content:
                  "Mari bersama membantu saudara kita yang membutuhkan melalui program donasi alumni.",
              image: "assets/donasi.png",
              date: "Open",
              location: "Semua Wilayah",
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  //                           TEMPLATE KARTU
  // =========================================================
  Widget _eventCard({
    required String title,
    required String img,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset(img, height: 70),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  //                     B O T T O M   N A V
  // =========================================================
  Widget _buildBottomNav() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, -2),
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _bottomNavItem(Icons.home, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }),
          _bottomNavItem(Icons.event, () {}),
          _bottomNavItem(Icons.person, () {}),
        ],
      ),
    );
  }

  Widget _bottomNavItem(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        size: 28,
        color: const Color(0xFF004E46),
      ),
    );
  }
}
