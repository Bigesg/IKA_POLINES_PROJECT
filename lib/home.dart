import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ================== ROOT APP ==================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 'const' dihapus dari MaterialApp untuk menambahkan theme
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // <<< REVISI 1: Menetapkan tema global untuk aplikasi
      theme: ThemeData(
        // Mengatur latar belakang default semua Scaffold (halaman) menjadi putih
        scaffoldBackgroundColor: Colors.white,
      ),

      home: const MainLayout(), // 'const' dipindahkan ke widget home
    );
  }
}

// ================== MAIN LAYOUT (FOOTER TETAP) ==================
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
    LokerPage(),
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

            // BANNER OTOMATIS
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
            const Text("Jangan Lewatkan!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 290, // Tinggi disesuaikan untuk kartu baru
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // GestureDetector dihapus, navigasi dipindah ke dalam _eventCard
                  _eventCard(
                    context, // Pass context
                    'assets/images/event_sarasehan.png',
                    'Sarasehan Alumni',
                    '8 Oktober 2025',
                    'Kumpul bareng alumni lintas angkatan.',
                    const EventPage(), // Pass halaman tujuan
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

            // <<< AWAL REVISI BEASISWA SECTION
            // BEASISWA SECTION
            const Text("Beasiswa",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // GestureDetector dihapus, karena tombol sudah ada di dalam kartu
            _beasiswaCard(context), // Panggil fungsi baru dengan context

            // <<< AKHIR REVISI BEASISWA SECTION

            const SizedBox(height: 28),

            // BANTUAN
            const Text("Bantuan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 190,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _bantuanCard(
                      'assets/images/bantuan_mekah.png',
                      'Bantu Muslim Indonesia ke Mekkah',
                      'Rp 24.000.000 terkumpul'),
                  _bantuanCard(
                      'assets/images/bantuan_pelosok.png',
                      'Bantu warga pelosok untuk makan siang',
                      'Rp 10.000.000 terkumpul'),
                  _bantuanCard('assets/images/bantuan_anak.png',
                      'Bantu anak-anak tersenyum', 'Rp 8.000.000 terkumpul'),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // LOKER
            const Text("Loker Terbuka untuk Kamu!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                _kategoriButton("Design", true),
                _kategoriButton("Business", false),
                _kategoriButton("Marketing", false),
                _kategoriButton("Tech", false),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 230,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _lokerCard(
                    context,
                    'assets/images/loker_ui_card.png',
                    'Invision',
                    'UI Designer',
                    'Jakarta, Indonesia - Onsite',
                    ['Remote', 'Contract'],
                  ),
                  _lokerCard(
                    context,
                    'assets/images/loker_marketing.png',
                    'Telegram',
                    'Digital Marketing',
                    'Jakarta, Indonesia - Onsite',
                    ['Remote', 'Fulltime'],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // DARI ALUMNI
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

  // === COMPONENTS ===
  static Widget _kategoriButton(String text, bool active) => Container(
        margin: const EdgeInsets.only(right: 8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: active ? Colors.teal : Colors.white,
            foregroundColor: active ? Colors.white : Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {},
          child: Text(text, style: const TextStyle(fontSize: 13)),
        ),
      );

  static Widget _eventCard(
    BuildContext context,
    String img,
    String title,
    String date,
    String desc,
    Widget pageToNavigate, // Halaman tujuan
  ) =>
      Container(
        width: 170, // Lebar kartu
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
        ),
        padding: const EdgeInsets.all(12), // Padding di dalam kartu
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar dengan border radius
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(img,
                  height: 100,
                  width: 146, // 170 (lebar) - 24 (padding L/R)
                  fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),

            // Judul
            Text(title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),

            // Tanggal (warna diubah)
            Text(date,
                style: const TextStyle(
                    fontSize: 12, color: Colors.teal)), // Diubah ke teal

            const SizedBox(height: 4),

            // Deskripsi
            Text(desc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12)),

            const Spacer(), // Mendorong tombol ke bawah

            // Tombol "Selengkapnya"
            SizedBox(
              width: double.infinity, // Lebar tombol penuh
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF004D40), // Warna dark teal (hijau tua)
                  foregroundColor: Colors.white, // Teks putih
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                onPressed: () {
                  // Aksi navigasi
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

  // <<< AWAL REVISI _beasiswaCard
  // === GANTI FUNGSI _beasiswaCard LAMA DENGAN YANG INI ===
  static Widget _beasiswaCard(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Biar gambar rata atas
          children: [
            // --- Kolom Teks (Kiri) ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul
                  const Text(
                    "Beasiswa Alumni Polines Peduli (Need-Based)",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 6),

                  // Deskripsi
                  const Text(
                    "Bantuan biaya pendidikan bagi mahasiswa aktif Polines yang membutuhkan dukungan finansial.",
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),

                  // --- Metadata dengan Ikon ---
                  _buildMetadataRow(Icons.person_outline, "25 Penerima"),
                  const SizedBox(height: 4),
                  _buildMetadataRow(Icons.calendar_today_outlined,
                      "8 October - 30 October 2025"),
                  const SizedBox(height: 4),
                  _buildMetadataRow(
                      Icons.apartment_outlined, "Forum Alumni Polines"),
                  const SizedBox(height: 12),

                  // --- Tombol Detail ---
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF004D40), // Warna dark teal
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
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

            // --- Gambar (Kanan) ---
            const SizedBox(width: 12),
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/images/beasiswa_alumni.png',
                    width: 100, height: 100, fit: BoxFit.cover)),
          ],
        ),
      );

  // --- FUNGSI HELPER BARU UNTUK BARIS METADATA ---
  static Widget _buildMetadataRow(IconData icon, String text) => Row(
        children: [
          Icon(icon, size: 16, color: Colors.black54),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      );
  // <<< AKHIR REVISI _beasiswaCard

  static Widget _bantuanCard(String img, String title, String collected) =>
      Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  Image.asset(img, width: 160, height: 90, fit: BoxFit.cover)),
          const SizedBox(height: 6),
          Text(title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600, height: 1.3)),
          Text(collected,
              style: const TextStyle(fontSize: 12, color: Colors.teal))
        ]),
      );

  static Widget _lokerCard(BuildContext context, String img, String comp,
          String pos, String loc, List<String> tags) =>
      Container(
        width: 200,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
        ),
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.asset(img, width: 45, height: 45),
            const SizedBox(height: 8),
            Text(comp,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            Text(pos, style: const TextStyle(fontSize: 13)),
            Text(loc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 6),
            Wrap(
                spacing: 6,
                runSpacing: 4,
                children: tags
                    .map((t) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(t,
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.black54)),
                        ))
                    .toList()),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailLokerPage(
                        company: comp,
                        position: pos,
                        location: loc,
                        tags: tags,
                        image: img,
                      ),
                    ),
                  );
                },
                child: const Text("Detail",
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ),
            )
          ]),
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
                    style:
                        const TextStyle(fontSize: 12, color: Colors.black87)),
              ]))
        ]),
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

class LokerPage extends StatelessWidget {
  const LokerPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Loker")),
        body: const Center(child: Text("Daftar Loker Lengkap")),
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

// ================== DETAIL LOKER PAGE ==================
class DetailLokerPage extends StatelessWidget {
  final String company;
  final String position;
  final String location;
  final List<String> tags;
  final String image;

  const DetailLokerPage({
    super.key,
    required this.company,
    required this.position,
    required this.location,
    required this.tags,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(position), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Image.asset(image, width: 70, height: 70),
              const SizedBox(width: 16),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(company,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text(location, style: const TextStyle(color: Colors.grey)),
              ]),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Deskripsi Pekerjaan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            "Bertanggung jawab untuk mendesain antarmuka aplikasi yang ramah pengguna dan sesuai identitas perusahaan.",
          ),
          const SizedBox(height: 16),
          const Text("Persyaratan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("• Minimal pengalaman 1 tahun di bidang terkait.\n"
              "• Menguasai Figma, Adobe XD.\n"
              "• Mampu bekerja dalam tim."),
          const Spacer(),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14)),
              onPressed: () {},
              child: const Text("Lamar Sekarang",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          )
        ]),
      ),
    );
  }
}
