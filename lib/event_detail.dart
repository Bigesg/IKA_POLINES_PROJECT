import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              color: Colors.grey[300],
              child: const Center(child: Text("gambar")),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const CircleAvatar(radius: 20, backgroundColor: Colors.grey),
                const SizedBox(width: 8),
                const Text("Izabel Peattie", style: TextStyle(fontSize: 16)),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004E46)),
                  child: const Text("Follow"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text("Minggu, 8 Oct 2025",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            const Text(
              "Elektro Expo",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text("GKT Lt 2, Politeknik Negeri Semarang"),
            const SizedBox(height: 16),
            const Text(
              "Tentang",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              "Elektro Expo adalah ajang tahunan terbesar yang diselenggarakan oleh Jurusan Teknik Elektro Polines..."
              "Acara ini menjadi wadah bagi mahasiswa untuk menampilkan inovasi teknologi, kreativitas, dan karya unggulan.",
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            const Text(
              "Tujuan Kegiatan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text("• Meningkatkan semangat inovasi dan kreativitas mahasiswa.\n"
                "• Mempresentasikan hasil penelitian.\n"
                "• Membangun kerja sama antar lembaga pendidikan."),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004E46),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("CONTACT"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
