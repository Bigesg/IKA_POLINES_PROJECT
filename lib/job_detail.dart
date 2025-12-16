import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// URL WhatsApp yang Diberikan Pengguna (digunakan sebagai basis jika tidak ada nomor admin)
const whatsappBaseUrl = "https://wa.me/6281234567890";

// =======================
// HALAMAN DETAIL PEKERJAAN
// =======================
class JobDetailPage extends StatefulWidget {
  final String company;
  final String position;
  final String location;
  final List<String> tags;
  final String image;
  final String? headerImage;
  final String? applyUrl;
  final String? mapsUrl;

  const JobDetailPage({
    super.key,
    required this.company,
    required this.position,
    required this.location,
    required this.tags,
    required this.image,
    this.headerImage,
    this.applyUrl,
    this.mapsUrl,
  });

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

// Warna Konstan
const Color _primaryBackgroundColor = Colors.white;
const Color _mainColor = Color(0xFF1E5A5D); 
const Color _tabActiveColor = Color(0xFF103C3F); 
const Color _tabInactiveColor = Colors.grey;
const String _whatsappAdminNumber = '081226747714'; 

class _JobDetailPageState extends State<JobDetailPage>
    with SingleTickerProviderStateMixin {
  
  bool showProfile = true;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // ignore: avoid_print
      print('Tidak dapat membuka $url');
    }
  }

  // Fungsi untuk WhatsApp Launch menggunakan format wa.me
  Future<void> _launchWhatsApp(String phoneNumber, String message) async {
    // Menggunakan nomor admin yang diminta, ganti 0 di depan menjadi 62
    final formattedNumber = phoneNumber.replaceFirst(RegExp(r'^0'), '62');
    
    // Menggunakan format https://wa.me/
    final url = 'https://wa.me/$formattedNumber?text=${Uri.encodeComponent(message)}';
    
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // ignore: avoid_print
      print('Tidak dapat membuka WhatsApp $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryBackgroundColor,
      // AppBar dengan tombol back kiri diaktifkan dan tombol kanan dihapus
      appBar: AppBar(
        title: const Text(''), 
        backgroundColor: _mainColor, 
        elevation: 0,
        foregroundColor: Colors.white,
        
        // TOMBOL BACK KIRI DIKEMBALIKAN
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(), 
        ),
        
        // TOMBOL KANAN DIHAPUS
        actions: const [], 
      ),
      body: Column(
        children: [
          _buildCompanyHeaderWidget(),
          _buildTopTabs(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) =>
                  FadeTransition(opacity: anim, child: child),
              child: SingleChildScrollView(
                key: ValueKey(showProfile),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: showProfile
                    ? _buildProfilePageUI() 
                    : _buildDescriptionPageUI(),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // --- Widget Header Perusahaan ---
  Widget _buildCompanyHeaderWidget() {
    return Container(
      width: double.infinity,
      color: _mainColor, 
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(widget.image),
            backgroundColor: Colors.grey.shade200,
          ),
          const SizedBox(height: 10),
          Text(
            widget.company,
            style: const TextStyle(
                color: Colors.white, 
                fontWeight: FontWeight.bold, 
                fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < 4 
                      ? Icons.star
                      : Icons.star_half,
                  color: Colors.amber,
                  size: 16,
                );
              }),
              const SizedBox(width: 5),
              const Text(
                '4.9 (349 ratings)',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Creatio Studio • ${widget.location}',
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
          ),
        ],
      ),
    );
  }
  
  // --- Widget Tombol Tab ---
  Widget _buildTopTabs() {
    return Container(
      decoration: BoxDecoration(
        color: _primaryBackgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _tabButton("PROFIL", showProfile, () {
            setState(() => showProfile = true);
          }),
          _tabButton("KETERANGAN", !showProfile, () {
            setState(() => showProfile = false);
          }),
        ],
      ),
    );
  }

  // Tombol tab dengan indikator garis bawah
  Widget _tabButton(String text, bool active, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? _tabActiveColor : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? _tabActiveColor : _tabInactiveColor,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // ===============================================
  // KONTEN PROFIL (TENTANG KAMI, Lokasi disamakan)
  // ===============================================

  Widget _buildProfilePageUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitleNew('TENTANG KAMI'),
        _textBlock(
          'Perusahaan ini adalah salah satu pemimpin di bidang teknologi modern, fokus pada inovasi dan pengembangan solusi digital yang berdampak positif bagi masyarakat.',
        ),
        const SizedBox(height: 16),

        _infoGrid(),
        const SizedBox(height: 16),

        _sectionTitleNew('VISI'),
        _textBlock(
          'Mengorganisasi informasi dunia dan membuatnya dapat diakses serta berguna bagi semua orang.',
        ),
        const SizedBox(height: 10),

        _sectionTitleNew('MISI'),
        _textBlock(
          '1. Memberikan akses informasi yang cepat dan relevan.\n'
          '2. Mendorong inovasi teknologi melalui kecerdasan buatan.\n'
          '3. Memberdayakan individu dan bisnis melalui produk digital.\n'
          '4. Membangun ekosistem kerja yang kreatif, inklusif, dan kolaboratif.',
        ),

        const SizedBox(height: 40),
      ],
    );
  }

  // Item kotak info grid (semua disamakan, non-tappable)
  Widget _infoGrid() {
    return Row(
      children: [
        _infoGridItem('LOKASI', widget.location), 
        const SizedBox(width: 10),
        _infoGridItem('POSISI', widget.position),
        const SizedBox(width: 10),
        _infoGridItem('PERUSAHAAN', widget.company),
      ],
    );
  }

  // Item kotak info grid (Styling baru)
  Widget _infoGridItem(String title, String content) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _tabActiveColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Widget judul bagian
  Widget _sectionTitleNew(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: _tabActiveColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Widget blok teks umum
  Widget _textBlock(String content) {
    return Text(
      content,
      style: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 13,
        height: 1.5,
      ),
    );
  }

  // ==================================================
  // KONTEN KETERANGAN (Apply Now ke WA)
  // ==================================================

  Widget _buildDescriptionPageUI() {
    final message = 'Halo admin, saya tertarik melamar posisi ${widget.position} di ${widget.company} yang saya lihat di aplikasi.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitleNew('DESKRIPSI PEKERJAAN'),
        _textBlock(
          'Sebagai ${widget.position} di ${widget.company}, Anda akan berkontribusi dalam merancang, mengembangkan, dan mengoptimalkan produk digital yang digunakan oleh jutaan pengguna di seluruh dunia.',
        ),
        const SizedBox(height: 16),
        
        // TOMBOL APPLY NOW MENGARAH KE WHATSAPP
        _applyButtonWhatsApp(_whatsappAdminNumber, message),
        const SizedBox(height: 16),
        
        _sectionTitleNew('JOB REQUIREMENT'),
        _textBlock(
          '• S1 Teknik Informatika / Ilmu Komputer\n'
          '• Pengalaman 1–3 tahun dalam pengembangan software\n'
          '• Pemahaman mendalam tentang struktur data dan algoritma\n'
          '• Kemampuan kolaborasi dan komunikasi yang kuat',
        ),
        const SizedBox(height: 16),
        
        _sectionTitleNew('REQUIRED SKILL'),
        _textBlock(
          '• Bahasa pemrograman: Python, Java, Go, C++\n'
          '• Cloud computing (Google Cloud, AWS)\n'
          '• Git, REST API, dan sistem terdistribusi\n'
          '• Machine Learning dan AI menjadi nilai tambah',
        ),
        
        const SizedBox(height: 40),
      ],
    );
  }
  
  // Tombol Apply Button yang mengarah ke WhatsApp
  Widget _applyButtonWhatsApp(String adminNumber, String message) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        // FUNGSI: Mengarah ke WA
        onPressed: () => _launchWhatsApp(adminNumber, message), 
        
        // Menggunakan ikon Send/Next
        icon: const Icon(Icons.send, size: 18), 
        label: const Text(
          'APPLY NOW (Chat via WA)', 
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E5A5D), // Warna Primary
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

// --- Painter segitiga (tidak digunakan) ---
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
