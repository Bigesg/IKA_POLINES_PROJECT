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

  // --- Fungsi buka URL ---
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Tidak dapat membuka $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF103C3F),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'GAMBAR',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
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
            _footerIcon(Icons.business_center, true), // Aktif
            _footerIcon(Icons.person, false),
          ],
        ),
      ),
    );
  }

  // --- Footer icon dengan kondisi aktif ---
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

  // --- Tombol atas (KETERANGAN / PROFIL) ---
  Widget _topButton(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: active ? Colors.tealAccent.withOpacity(0.3) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.tealAccent),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // --- Bagian PROFIL ---
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
          'Menjadi perusahaan teknologi terkemuka yang menciptakan solusi perangkat lunak inovatif dan berkelanjutan untuk mendukung transformasi digital global.\n\n'
          'Company A berkomitmen memberdayakan talenta lokal agar mampu bersaing di tingkat internasional melalui inovasi, kolaborasi, dan kualitas unggul.',
        ),
        const SizedBox(height: 10),
        _sectionTitle('MISI'),
        _infoCard(
          '1. Mengembangkan produk dan layanan perangkat lunak berkualitas.\n'
          '2. Memberdayakan talenta muda Indonesia.\n'
          '3. Mendorong transformasi digital di berbagai sektor industri.\n'
          '4. Membentuk budaya kerja kolaboratif dan kreatif.\n'
          '5. Berkomitmen terhadap kualitas dan kepuasan pelanggan.',
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // --- Header perusahaan + media sosial aktif ---
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
          Row(
            children: const [
              CircleAvatar(radius: 20, backgroundColor: Colors.white),
              SizedBox(width: 10),
              Text(
                'COMPANY A',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text('ABOUT US',
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text(
            'Company A berkomitmen mengembangkan solusi perangkat lunak inovatif untuk pasar global.\n'
            'Kami membuka kesempatan bagi talenta Software Engineer di Semarang untuk bergabung dan tumbuh bersama tim profesional kami.\n'
            'Informasi lebih lanjut tersedia di situs web dan media sosial resmi kami.',
            style: TextStyle(color: Colors.white70, height: 1.4),
          ),
          const SizedBox(height: 8),

          // Ikon media sosial bisa ditekan
          Row(
            children: [
              IconButton(
                onPressed: () => _launchUrl('https://company-a.com'),
                icon: const Icon(Icons.link, color: Colors.white),
              ),
              IconButton(
                onPressed: () => _launchUrl('https://facebook.com/companyA'),
                icon: const Icon(Icons.facebook, color: Colors.white),
              ),
              IconButton(
                onPressed: () => _launchUrl('https://twitter.com/companyA'),
                icon: const Icon(Icons.language, color: Colors.white),
              ),
              IconButton(
                onPressed: () => _launchUrl('https://instagram.com/companyA'),
                icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Info tambahan ---
  Widget _infoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _smallInfoCard(Icons.location_on, 'LOKASI', 'Jl. Fantasy no.99\nSemarang'),
        _smallInfoCard(Icons.people, 'KARYAWAN', '1,234'),
        _smallInfoCard(Icons.computer, 'INDUSTRI', 'Software'),
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

  // --- Halaman "KETERANGAN" ---
  Widget _buildDescriptionPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _companyHeader(),
        const SizedBox(height: 16),
        _sectionTitle('DESKRIPSI PEKERJAAN'),
        _infoCard(
          'Sebagai Software Engineer di Company A, Anda akan berperan penting dalam merancang, mengembangkan, dan memelihara aplikasi berbasis web maupun mobile.',
        ),
        const SizedBox(height: 10),
        _sectionTitle('JOB REQUIREMENT'),
        _infoCard(
          '• D3 - S1 Informatika, SI, RPL\n'
          '• Fresh Graduate / 1-2 tahun pengalaman\n'
          '• Kemampuan analisis dan logika yang baik',
        ),
        const SizedBox(height: 10),
        _sectionTitle('REQUIRED SKILL'),
        _infoCard(
          '• JavaScript / Python / PHP / Java / C#\n'
          '• MySQL, PostgreSQL, MongoDB\n'
          '• Familiar Git, REST API',
        ),
        const SizedBox(height: 10),
        _sectionTitle('TANGGUNG JAWAB'),
        _infoCard(
          '• Mengembangkan dan memelihara aplikasi\n'
          '• Berkolaborasi dengan tim desain dan QA',
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
