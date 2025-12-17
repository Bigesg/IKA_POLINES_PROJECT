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
  final String image; // job image or company logo/url
  final String? headerImage;
  final String? applyUrl;
  final String? mapsUrl;

  // Additional dynamic fields from perusahaan
  final String? companyLogo;
  final String? rating;
  final String? tentangKami;
  final String? visi;
  final String? misi;
  // Job detail fields
  final String? deskripsiPekerjaan;
  final String? jobRequirement;
  final String? requiredSkill;

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
    this.companyLogo,
    this.rating,
    this.tentangKami,
    this.visi,
    this.misi,
    this.deskripsiPekerjaan,
    this.jobRequirement,
    this.requiredSkill,
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
            backgroundColor: Colors.grey.shade200,
            backgroundImage: widget.companyLogo != null && widget.companyLogo!.isNotEmpty
                ? NetworkImage(widget.companyLogo!) as ImageProvider
                : (widget.image.isNotEmpty
                    ? NetworkImage(widget.image)
                    : null),
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
                // show filled stars based on rating if available
                final r = double.tryParse(widget.rating ?? '0') ?? 0.0;
                if (index + 1 <= r.floor()) {
                  return const Icon(Icons.star, color: Colors.amber, size: 16);
                } else if (index < r && r - r.floor() >= 0.5) {
                  return const Icon(Icons.star_half, color: Colors.amber, size: 16);
                } else {
                  return const Icon(Icons.star_border, color: Colors.amber, size: 16);
                }
              }),
              const SizedBox(width: 5),
              Text(
                widget.rating != null ? '${widget.rating} (ratings)' : '-',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.location}',
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
        _textBlock(widget.tentangKami ?? 'Tidak ada informasi tentang perusahaan.'),
        const SizedBox(height: 16),

        _infoGrid(),
        const SizedBox(height: 16),

        _sectionTitleNew('VISI'),
        _textBlock(widget.visi ?? '-'),
        const SizedBox(height: 10),

        _sectionTitleNew('MISI'),
        _textBlock(widget.misi ?? '-'),

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
        _textBlock(widget.deskripsiPekerjaan ?? 'Sebagai ${widget.position} di ${widget.company}, Anda akan berkontribusi dalam merancang, mengembangkan, dan mengoptimalkan produk digital yang digunakan oleh jutaan pengguna di seluruh dunia.'),
        const SizedBox(height: 16),
        
        // TOMBOL APPLY NOW MENGARAH KE WHATSAPP
        _applyButtonWhatsApp(_whatsappAdminNumber, message),
        const SizedBox(height: 16),
        
        _sectionTitleNew('JOB REQUIREMENT'),
        if (widget.jobRequirement != null && widget.jobRequirement!.trim().isNotEmpty)
          _bulletListFromText(widget.jobRequirement!)
        else
          _textBlock('• S1 Teknik Informatika / Ilmu Komputer\n• Pengalaman 1–3 tahun dalam pengembangan software\n• Pemahaman mendalam tentang struktur data dan algoritma\n• Kemampuan kolaborasi dan komunikasi yang kuat'),
        const SizedBox(height: 16),
        
        _sectionTitleNew('REQUIRED SKILL'),
        if (widget.requiredSkill != null && widget.requiredSkill!.trim().isNotEmpty)
          _bulletListFromText(widget.requiredSkill!)
        else
          _textBlock('• Bahasa pemrograman: Python, Java, Go, C++\n• Cloud computing (Google Cloud, AWS)\n• Git, REST API, dan sistem terdistribusi\n• Machine Learning dan AI menjadi nilai tambah'),
        
        const SizedBox(height: 40),
      ],
    );
  }

  // Convert newline-separated text into bullet list widgets
  Widget _bulletListFromText(String text) {
    final lines = text.split(RegExp(r'\r?\n')).map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (lines.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        // remove leading bullet char if present
        final cleaned = line.replaceFirst(RegExp(r'^\s*[•\-*]\s*'), '');
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• ', style: TextStyle(fontSize: 14, color: Colors.grey)),
              Expanded(child: Text(cleaned, style: TextStyle(color: Colors.grey.shade700, height: 1.4))),
            ],
          ),
        );
      }).toList(),
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