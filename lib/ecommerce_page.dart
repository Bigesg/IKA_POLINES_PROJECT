import 'package:flutter/material.dart';
import '../models/koperasi_model.dart';
import 'ecommerce_detail_page.dart';

class EcommercePage extends StatelessWidget {
  final List<Koperasi> koperasiList = [
    Koperasi(
      name: "Koperasi Mhs",
      image: "assets/images/mhs.png",
      updated: "Updated today",
      description: "Koperasi Mahasiswa Polines melayani kebutuhan harian mahasiswa.",
    ),
    Koperasi(
      name: "Koperasi IKA",
      image: "assets/images/ika.png",
      updated: "Updated yesterday",
      description: "Koperasi IKA menaungi berbagai produk alumni POLINES.",
    ),
    Koperasi(
      name: "Koperasi Polines",
      image: "assets/images/polines.png",
      updated: "Updated 2 days ago",
      description: "Koperasi resmi kampus POLINES dengan produk unggulan kampus.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ecommerce"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Bagian atas
          Image.asset("assets/images/temcit.png", height: 180, fit: BoxFit.cover),
          const SizedBox(height: 8),
          const Text(
            "Temcit Chicken\nJl. Gondang Raya, Bulusan",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),

          // Daftar koperasi
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: koperasiList.length,
              itemBuilder: (context, index) {
                final koperasi = koperasiList[index];
                return GestureDetector(
                  onTap: () {
                    // 🎬 Transisi pakai PageRouteBuilder
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 600),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            EcommerceDetailPage(koperasi: koperasi),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0); // dari kanan
                          const end = Offset.zero;
                          final tween = Tween(begin: begin, end: end)
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
                    width: 170,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(koperasi.image, height: 80),
                        const SizedBox(height: 8),
                        Text(
                          koperasi.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          koperasi.updated,
                          style: const TextStyle(color: Colors.grey),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
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
