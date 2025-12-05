import 'dart:async';
import 'package:flutter/material.dart';
import 'beasiswadetail.dart'; // Import halaman beasiswa yang detail
import 'loker.dart'; // Import halaman loker yang asli
import 'event.dart'; // Import halaman event yang baru
import 'ecommerce_page.dart'; // Import halaman ecommerce
import 'notification_service.dart'; // Import notification service
import 'notification_page.dart'; // Import notification page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _bannerIndex = 0;
  late Timer _timer;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final NotificationService _notificationService = NotificationService();

  final List<String> _banners = [
    'assets/images/banner_beasiswa.png',
    'assets/images/event_sarasehan.png',
    'assets/images/event_elektro.png',
  ];

  @override
  void initState() {
    super.initState();
    _notificationService.initializeNotifications(); // Initialize notifications
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _bannerIndex = (_bannerIndex + 1) % _banners.length;
        });
      }
    });

    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
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

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          // === BACKGROUND ANIMASI ===
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: -screenHeight * 0.15,
                    left: -screenWidth * 0.2,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: screenWidth * 0.7,
                        height: screenWidth * 0.7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.teal.shade50.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.1,
                    right: -screenWidth * 0.15,
                    child: Transform.scale(
                      scale: _scaleAnimation.value * 0.9,
                      child: Container(
                        width: screenWidth * 0.35,
                        height: screenWidth * 0.35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.teal.shade100.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // === KONTEN UTAMA ===
          Material(
            type: MaterialType.transparency,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.teal, width: 2),
                          ),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/profile_ui.png',
                            ),
                            radius: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Hi, Jerel",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            Text(
                              "Selamat datang di IKA Polines!",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const NotificationPage(),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.notifications_none,
                                  color: Colors.black87,
                                ),
                              ),
                              // Badge for unread notifications
                              ValueListenableBuilder<int>(
                                valueListenable: ValueNotifier(
                                  _notificationService.getUnreadCount(),
                                ),
                                builder: (context, unreadCount, child) {
                                  if (unreadCount > 0) {
                                    return Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          unreadCount.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // BANNER SLIDER
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
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
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // === EVENT SECTION (DENGAN ICON) ===
                    _buildSectionHeader("Agenda Kampus", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const EventPage()),
                      );
                    }),
                    const SizedBox(height: 12),

                    SizedBox(
                      height: 280,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        children: [
                          _eventCard(
                            context,
                            'assets/images/event_sarasehan.png',
                            'Sarasehan Alumni',
                            '8 Okt 2025',
                            'Kumpul bareng alumni.',
                            const EventPage(),
                          ),
                          _eventCard(
                            context,
                            'assets/images/event_elektro.png',
                            'Elektro Expo 2025',
                            '12 Okt 2025',
                            'Ajang karya mahasiswa.',
                            const EventPage(),
                          ),
                          _eventCard(
                            context,
                            'assets/images/event_webinar.png',
                            'Webinar Karir',
                            '15 Okt 2025',
                            'Tips jitu lolos HRD.',
                            const EventPage(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // === BEASISWA SECTION ===
                    const Text(
                      "Beasiswa",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _beasiswaCard(context),

                    const SizedBox(height: 28),

                    // === BANTUAN SECTION ===
                    const Text(
                      "Bantuan Sosial",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
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

                    // === LOKER SECTION ===
                    const Text(
                      "Loker Terbuka!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // BANNER LOKER
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const JobListPage(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF004D40), Color(0xFF009688)],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF009688).withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -20,
                              left: -20,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.1),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -40,
                              right: 40,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.08),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                              0.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: const Text(
                                            "HOT VACANCY",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          "Temukan Karir\nImpianmu Disini!",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            height: 1.2,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: const [
                                            Text(
                                              "Cek Sekarang",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Icon(
                                              Icons.arrow_forward_rounded,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.business_center_rounded,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // === ALUMNI SECTION ===
                    const Text(
                      "Dari Alumni untuk Alumni",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
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

                    // TAMBAHKAN E-COMMERCE KOPERASI DI SINI
                    _alumniCard(
                      'assets/images/ika.png',
                      'E-Commerce Koperasi',
                      'Belanja produk & layanan mitra.',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => EcommercePage()),
                        );
                      },
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // === COMPONENTS ===
  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            "Lihat Semua",
            style: TextStyle(
              fontSize: 12,
              color: Colors.teal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _eventCard(
    BuildContext context,
    String img,
    String title,
    String date,
    String desc,
    Widget pageToNavigate,
  ) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 14, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              img,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                height: 100,
                color: Colors.teal.shade50,
                child: const Center(
                  child: Icon(Icons.image, color: Colors.teal),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 14,
                      color: Colors.teal,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        date,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.teal,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 32,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004D40),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => pageToNavigate),
                      );
                    },
                    child: const Text(
                      "Detail",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _beasiswaCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Beasiswa",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Beasiswa Alumni Polines",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Bantuan biaya pendidikan bagi mahasiswa berprestasi.",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildMetadataRow(Icons.person_outline, "25 Kuota"),
                    const SizedBox(width: 12),
                    _buildMetadataRow(Icons.access_time, "3 Hari Lagi"),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004D40),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BeasiswaDetailPage(
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
                    child: const Text(
                      "Cek Syarat",
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/beasiswa_alumni.png',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) =>
                  Container(width: 90, height: 90, color: Colors.grey.shade200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _bantuanCard(String img, String title, String contactPhone) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12, bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              img,
              width: double.infinity,
              height: 85,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) =>
                  Container(height: 85, color: Colors.grey.shade200),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              height: 1.2,
              color: Color(0xFF1F2937),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Icon(
                Icons.phone_in_talk_outlined,
                size: 14,
                color: Colors.teal.shade700,
              ),
              const SizedBox(width: 4),
              Text(
                contactPhone,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.teal.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // UPDATE: Menambahkan parameter onTap yang opsional
  Widget _alumniCard(
    String img,
    String title,
    String desc, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                img,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey.shade200,
                ),
              ),
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
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
