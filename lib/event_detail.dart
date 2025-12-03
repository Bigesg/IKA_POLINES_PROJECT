import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final String title;
  final String content;

  const EventDetailPage({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: SafeArea(
        child: Column(
          children: [
            // ===================== HEADER GAMBAR =====================
            Container(
              width: double.infinity,
              height: 220,
              decoration: const BoxDecoration(
                color: Color(0xFF004E46),
              ),
              child: const Center(
                child: Text(
                  "gambar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // ===================== TOMBOL BACK ======================
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.5)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back, size: 16),
                          SizedBox(width: 6),
                          Text("Back"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ===================== KONTEN DETAIL =====================
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------- Profil Penulis ----------
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Izabel Peattie",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              Text("Dosen",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: const Text("Follow",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          )
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ---------- Tanggal ----------
                      const Text(
                        "Minggu, 8 Oct 2025",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 5),

                      // ---------- Judul ----------
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        "GKT Lt 2, Politeknik Negeri Semarang",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ---------- Tentang ----------
                      const Text(
                        "Tentang",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        content,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(height: 1.5),
                      ),

                      const SizedBox(height: 20),

                      // ---------- Tujuan ----------
                      const Text(
                        "Tujuan Kegiatan",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      const Text(
                        "• Meningkatkan semangat inovasi dan kreativitas di kalangan mahasiswa.\n"
                        "• Memperkenalkan hasil penelitian dan pengembangan teknologi terbaru.\n"
                        "• Memberikan wawasan kepada masyarakat luas.\n"
                        "• Menjalin koneksi antara kampus, industri, dan alumni.\n"
                        "• Memberikan inspirasi bagi generasi muda untuk terus berkreasi.",
                        style: TextStyle(height: 1.5),
                      ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),

            // ===================== BUTTON CONTACT =====================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, -2))
                ],
              ),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF004E46),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "CONTACT",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
