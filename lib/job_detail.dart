import 'package:flutter/material.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({super.key});

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage>
    with SingleTickerProviderStateMixin {
  bool showProfile = true;

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

            // Isi halaman dengan animasi fade
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: child,
                ),
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

      // Footer (ikon saja)
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xFF0B2E30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _footerIcon(Icons.home),
            _footerIcon(Icons.business_center),
            _footerCenterIcon(),
            _footerIcon(Icons.document_scanner_outlined),
            _footerIcon(Icons.person_outline),
          ],
        ),
      ),
    );
  }

  // Tombol atas (KETERANGAN / PROFIL)
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

  // Footer ikon kecil
  Widget _footerIcon(IconData icon) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white, size: 26),
    );
  }

  // Footer ikon tengah menonjol
  Widget _footerCenterIcon() {
    return Container(
      height: 48,
      width: 48,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white10,
      ),
      child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 28),
    );
  }

  // Bagian PROFIL
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
          '1. Mengembangkan produk dan layanan perangkat lunak yang berkualitas, efisien, dan berdaya saing internasional.\n'
          '2. Memberdayakan talenta muda Indonesia, khususnya di bidang rekayasa perangkat lunak, untuk tumbuh dan berinovasi.\n'
          '3. Mendorong transformasi digital di berbagai sektor industri.\n'
          '4. Membentuk budaya kerja kolaboratif, kreatif, dan berorientasi pada solusi.\n'
          '5. Berkomitmen terhadap kualitas, keamanan, dan kepuasan pelanggan di setiap produk yang dihasilkan.',
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // Header perusahaan
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
              Text('COMPANY A',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
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
          Row(
            children: const [
              Icon(Icons.link, color: Colors.white),
              SizedBox(width: 8),
              Icon(Icons.facebook, color: Colors.white),
              SizedBox(width: 8),
              Icon(Icons.language, color: Colors.white),
              SizedBox(width: 8),
              Icon(Icons.camera_alt_outlined, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  // Baris info lokasi/karyawan/industri
  Widget _infoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _smallInfoCard(Icons.location_on, 'LOKASI',
            'Jl. Fantasy no.99,\nSemarang 5555'),
        _smallInfoCard(Icons.people, 'TOTAL KARYAWAN', '1,234'),
        _smallInfoCard(Icons.computer, 'BIDANG INDUSTRY', 'Software\nEngineering'),
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

  // Halaman "KETERANGAN"
  Widget _buildDescriptionPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _companyHeader(),
        const SizedBox(height: 16),
        _sectionTitle('DESKRIPSI PEKERJAAN'),
        _infoCard(
          'Sebagai Software Engineer di Company A, Anda akan berperan penting dalam merancang, mengembangkan, dan memelihara aplikasi berbasis web maupun mobile yang inovatif serta memiliki performa tinggi.\n\n'
          'Peran ini menuntut kemampuan logika dan analisis yang kuat untuk menghasilkan solusi perangkat lunak yang efisien, aman, dan sesuai dengan kebutuhan pengguna.',
        ),
        const SizedBox(height: 10),
        _sectionTitle('JOB REQUIREMENT'),
        _infoCard(
          '• D3 - S1 Teknik Informatika, Sistem Informasi, Rekayasa Perangkat Lunak, atau bidang terkait.\n'
          '• Fresh Graduate / 1-2 tahun pengalaman.\n'
          '• Memiliki kemampuan analisis logika dan pemecahan masalah yang baik.',
        ),
        const SizedBox(height: 10),
        _sectionTitle('REQUIRED SKILL'),
        _infoCard(
          '• Bahasa pemrograman: JavaScript / Python / PHP / Java / C#\n'
          '• Database: MySQL, PostgreSQL, MongoDB\n'
          '• Familiar dengan Git (GitHub / GitLab)\n'
          '• Menguasai konsep API (REST / JSON)',
        ),
        const SizedBox(height: 10),
        _sectionTitle('TANGGUNG JAWAB'),
        _infoCard(
          '• Mengembangkan, menguji, dan memelihara aplikasi berbasis web maupun mobile sesuai standar pengembangan perangkat lunak perusahaan.\n'
          '• Berkolaborasi dengan tim desain, produk, dan QA untuk memastikan performa dan kualitas aplikasi berjalan optimal.',
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
