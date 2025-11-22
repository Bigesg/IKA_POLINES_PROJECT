import 'package:flutter/material.dart';

void main() {
  runApp(const IKACardApp());
}

class IKACardApp extends StatelessWidget {
  const IKACardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IKA Card',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF163D39),
      ),
      home: const IKACardScreen(),
    );
  }
}

class IKACardScreen extends StatelessWidget {
  const IKACardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color darkGreen = const Color(0xFF163D39);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        title: const Text(
          'IKA Card',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          children: [

            // ================= TOP AREA =================
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Placeholder gambar di kiri
                Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.blueAccent, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Image',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                // `Rp. 0` di depan (kanan) gambar, sejajar secara vertikal
                const Text(
                  'Rp. 0',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ================== CARD NUMBER ==================
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Card Number',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),

                // Kontrol sederhana: teks dengan underline di bawahnya
                Container(
                  padding: EdgeInsets.zero,
                  height: 45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            '(5784)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          Icon(
                            Icons.expand_more,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(height: 1, color: Colors.black54),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ================= BUTTON LIST =================
            buildMenuButton('Account Transaction History', darkGreen),
            const SizedBox(height: 15),
            buildMenuButton('Change Password', darkGreen),
            const SizedBox(height: 15),
            buildMenuButton('Report Lost Card', darkGreen),
          ],
        ),
      ),
    );
  }

  // Button builder
  Widget buildMenuButton(String title, Color bgColor) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
