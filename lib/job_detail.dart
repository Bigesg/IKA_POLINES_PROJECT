import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({super.key});

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage>
    with SingleTickerProviderStateMixin {
  bool showProfile = true;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Tidak dapat membuka $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- Corak dekoratif background ---
          Positioned(
            top: -60,
            left: -50,
            child: _abstractCircle(180, Colors.teal.withOpacity(0.15)),
          ),
          Positioned(
            top: 100,
            right: -60,
            child: _abstractCircle(120, Colors.teal.withOpacity(0.1)),
          ),
          Positioned(
            bottom: 100,
            left: -40,
            child: _abstractCircle(140, Colors.teal.withOpacity(0.08)),
          ),
          Positioned(
            bottom: -60,
            right: -30,
            child: _abstractCircle(180, Colors.teal.withOpacity(0.12)),
          ),
          Positioned(
            top: 200,
            left: 60,
            child: Transform.rotate(
              angle: 0.3,
              child: _triangleShape(60, Colors.purple.withOpacity(0.1)),
            ),
          ),

          // --- Konten utama ---
          SafeArea(
            child: Column(
              children: [
                // Gambar header (logo besar Google)
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/google.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Tombol tab atas
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _topButton("KETERANGAN", !showProfile, () {
                      setState(() => showProfile = false);
                    }),
                    const SizedBox(width: 10),
                    _topButton("PROFIL", showProfile, () {
                      setState(() => showProfile = true);
                    }),
                  ],
                ),
                const SizedBox(height: 20),

                // Isi halaman
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, anim) =>
                        FadeTransition(opacity: anim, child: child),
                    child: SingleChildScrollView(
                      key: ValueKey(showProfile),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: showProfile
                          ? _buildProfilePage()
                          : _buildDescriptionPage(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Footer (ikon bawah)
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _footerIcon(Icons.home, false),
            _footerIcon(Icons.school, false),
            _footerIcon(Icons.insert_drive_file, false),
            _footerIcon(Icons.business_center, true),
            _footerIcon(Icons.person, false),
          ],
        ),
      ),
    );
  }

  // --- Corak lingkaran ---
  Widget _abstractCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  // --- Corak segitiga ---
  Widget _triangleShape(double size, Color color) {
    return CustomPaint(
      size: Size(size, size),
      painter: _TrianglePainter(color),
    );
  }

  // --- Footer icon ---
  Widget _footerIcon(IconData icon, bool active) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        icon,
        size: 30,
        color: active ? const Color(0xFF103C3F) : Colors.grey.shade400,
      ),
    );
  }

  // --- Tombol atas ---
  Widget _topButton(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFF103C3F).withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF103C3F)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: const Color(0xFF103C3F),
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // --- PROFIL ---
  Widget _buildProfilePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _companyHeader(),
        const SizedBox(height: 10),
        _infoRow(),
        const SizedBox(height: 16),
        _sectionTitle('VISI'),
        _infoCard(
          'Mengorganisasi informasi dunia dan membuatnya dapat diakses serta berguna bagi semua orang.',
        ),
        const SizedBox(height: 10),
        _sectionTitle('MISI'),
        _infoCard(
          '1. Memberikan akses informasi yang cepat dan relevan.\n'
          '2. Mendorong inovasi teknologi melalui kecerdasan buatan.\n'
          '3. Memberdayakan individu dan bisnis melalui produk digital.\n'
          '4. Membangun ekosistem kerja yang kreatif, inklusif, dan kolaboratif.',
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // --- Bagian HEADER (ABOUT US + ikon sosial) ---
  Widget _companyHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E5A5D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo & Nama Perusahaan
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/images/google.jpg'),
              ),
              const SizedBox(width: 10),
              const Text(
                'Google Company',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'ABOUT US',
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Google Company adalah perusahaan teknologi global yang didirikan pada tahun 1998 oleh Larry Page dan Sergey Brin. '
            'Misi utama Google adalah mengorganisasi informasi dunia dan membuatnya dapat diakses serta berguna bagi semua orang. '
            'Produk utama Google meliputi mesin pencari Google Search, Android, Gmail, Chrome, YouTube, dan Google Cloud. '
            'Google juga dikenal sebagai pelopor inovasi dalam kecerdasan buatan, data center efisien, serta teknologi berkelanjutan.',
            style: TextStyle(color: Colors.white70, height: 1.4),
          ),
          const SizedBox(height: 12),
          // Ikon media sosial
          Row(
            children: [
              _socialIcon('assets/images/Linkedin.png',
                  'https://www.linkedin.com/company/google'),
              const SizedBox(width: 10),
              _socialIcon('assets/images/facebook.png',
                  'https://www.facebook.com/Google'),
              const SizedBox(width: 10),
              _socialIcon(
                  'assets/images/web.png', 'https://about.google/'),
              const SizedBox(width: 10),
              _socialIcon('assets/images/instagram_icon.png',
                  'https://www.instagram.com/google'),
            ],
          ),
        ],
      ),
    );
  }

  // --- Widget ikon sosial ---
  Widget _socialIcon(String assetPath, String url) {
    return InkWell(
      onTap: () => _launchUrl(url),
      child: Image.asset(
        assetPath,
        width: 30,
        height: 30,
      ),
    );
  }

  Widget _infoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _smallInfoCard(Icons.location_on, 'LOKASI',
            'Mountain View, California\nUSA'),
        _smallInfoCard(Icons.people, 'KARYAWAN', '190,000+'),
        _smallInfoCard(Icons.computer, 'INDUSTRI', 'Teknologi Informasi'),
      ],
    );
  }

  Widget _smallInfoCard(IconData icon, String title, String content) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E5A5D),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 8),
            Text(title,
                style: const TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(content,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E5A5D),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _infoCard(String content) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E5A5D),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(content,
          style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
    );
  }

  // --- KETERANGAN ---
  Widget _buildDescriptionPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _companyHeader(),
        const SizedBox(height: 16),
        _sectionTitle('DESKRIPSI PEKERJAAN'),
        _infoCard(
          'Sebagai Software Engineer di Google Company, Anda akan berkontribusi dalam merancang, mengembangkan, dan mengoptimalkan produk digital '
          'yang digunakan oleh miliaran pengguna di seluruh dunia.',
        ),
        const SizedBox(height: 10),
        _sectionTitle('JOB REQUIREMENT'),
        _infoCard(
          '• S1 Teknik Informatika / Ilmu Komputer\n'
          '• Pengalaman 1–3 tahun dalam pengembangan software\n'
          '• Pemahaman mendalam tentang struktur data dan algoritma\n'
          '• Kemampuan kolaborasi dan komunikasi yang kuat',
        ),
        const SizedBox(height: 10),
        _sectionTitle('REQUIRED SKILL'),
        _infoCard(
          '• Bahasa pemrograman: Python, Java, Go, C++\n'
          '• Cloud computing (Google Cloud, AWS)\n'
          '• Git, REST API, dan sistem terdistribusi\n'
          '• Machine Learning dan AI menjadi nilai tambah',
        ),
        const SizedBox(height: 10),
        _sectionTitle('TANGGUNG JAWAB'),
        _infoCard(
          '• Mengembangkan dan memelihara layanan Google\n'
          '• Berinovasi untuk meningkatkan kinerja sistem\n'
          '• Berkolaborasi lintas tim dalam proyek berskala global\n'
          '• Menjaga keamanan dan privasi data pengguna',
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

// --- Painter segitiga ---
class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
