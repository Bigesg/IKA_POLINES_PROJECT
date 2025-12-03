import 'package:flutter/material.dart';

class DonasiDetailPage extends StatelessWidget {
  final String title;
  final String content;
  final String image;
  final String date;
  final String location;

  const DonasiDetailPage({
    super.key,
    required this.title,
    required this.content,
    required this.image,
    required this.date,
    required this.location,
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
              decoration: BoxDecoration(
                color: const Color(0xFF004E46),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  onError: (_, __) {},
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.25),
                child: const Center(
                  child: Text(
                    "DONASI DETAIL",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // ===================== BACK BUTTON ======================
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black45),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back, size: 16),
                        SizedBox(width: 6),
                        Text("Back"),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ===================== CONTENT =====================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ikatan Alumni Polines",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text("Admin",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Text(
                        date,
                        style: const TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Tentang Program Donasi",
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

                      const Text(
                        "Tujuan Donasi",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "• Membantu mahasiswa kurang mampu\n"
                        "• Mendukung kegiatan sosial\n"
                        "• Membantu korban bencana\n"
                        "• Meningkatkan solidaritas alumni\n"
                        "• Menumbuhkan rasa peduli",
                        style: TextStyle(height: 1.5),
                      ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),

            // ===================== DONATE BUTTON =====================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, -2),
                  )
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
                    "DONASI SEKARANG",
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
