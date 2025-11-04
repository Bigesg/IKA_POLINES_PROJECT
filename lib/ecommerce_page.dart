import 'package:flutter/material.dart';
import '../models/koperasi_model.dart';
import 'ecommerce_detail_page.dart';

class EcommercePage extends StatelessWidget {
  final List<Koperasi> koperasiList = [
    Koperasi(
      name: "Koperasi Mahasiswa",
      image: "assets/images/kopma.png",
      updated: "Updated today",
      description: "Koperasi Mahasiswa Polines melayani kebutuhan harian mahasiswa.",
    ),
    Koperasi(
      name: "Koperasi IKA",
      image: "assets/images/ika.png",
      updated: "Updated yesterday",
      description: "Koperasi IKA menaungi produk dan usaha alumni POLINES, mendukung jejaring bisnis antar alumni.",
    ),
    Koperasi(
      name: "Koperasi Polines",
      image: "assets/images/polines.png",
      updated: "Updated 2 days ago",
      description: "Koperasi Polines merupakan unit resmi yang dinaungi oleh Polines.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Ecommerce",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          // 🔹 Background shape atas
          Positioned(
            top: -100,
            left: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                color: Color(0xFFCCE7E7),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // 🔹 Background shape bawah
          Positioned(
            bottom: -100,
            right: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0xFFD8ECEC),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // 🔹 Konten utama
          Column(
            children: [
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/ika.png",
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "IKA POLINES PARTNER",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Text(
                "GKT Lt.2, Ruang 202, Politeknik Negeri Semarang",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // 🔹 Daftar koperasi
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: koperasiList.length,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, index) {
                    final koperasi = koperasiList[index];
                    return GestureDetector(
                      onTap: () {
                        // 🔸 Animasi transisi ke halaman detail
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 600),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    EcommerceDetailPage(koperasi: koperasi),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              final tween = Tween(
                                      begin: const Offset(1, 0),
                                      end: Offset.zero)
                                  .chain(CurveTween(curve: Curves.easeInOut));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 180,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(koperasi.image, height: 70),
                            const SizedBox(height: 10),
                            Text(
                              koperasi.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              koperasi.updated,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF1C7C7C),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        ],
      ),
    );
  }
}
