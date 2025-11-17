import 'package:flutter/material.dart';

class DonasiPage extends StatelessWidget {
  const DonasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Event',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                tabItem("Berita", false),
                tabItem("Beasiswa", false),
                tabItem("Donasi", true),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Image.asset(
                      'assets/donasi_logo.png', //logo buat donasi nanti
                      height: 100,
                    )),
                    const SizedBox(height: 16),
                    const Text(
                      "Donasi IKA Polines. Dari Polines, untuk Polines",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Donasi IKA Polines merupakan program bantuan yang diberikan oleh Ikatan Alumni Polines (IKA Polines) bagi mahasiswa aktif maupun Alumni untuk segala kebutuhan mulai dari Sponsorship, terkena musibah, maupun untuk alumni yang membutuhkan.",
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    const Text("Kriteria",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.people, size: 16),
                        SizedBox(width: 4),
                        Text("25 Penerima"),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16),
                        SizedBox(width: 4),
                        Text("8 Oktober - 30 Oktober 2025"),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.forum, size: 16),
                        SizedBox(width: 4),
                        Text("Forum Alumni Polines"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF004E46),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24)),
                        child: const Text("Daftar Sekarang"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tabItem(String title, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF004E46) : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(color: isActive ? Colors.white : Colors.black),
      ),
    );
  }
}
