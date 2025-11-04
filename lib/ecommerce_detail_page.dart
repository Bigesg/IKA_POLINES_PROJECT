import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/koperasi_model.dart';

class EcommerceDetailPage extends StatelessWidget {
  final Koperasi koperasi;

  const EcommerceDetailPage({super.key, required this.koperasi});

  // 🔹 Fungsi untuk buka Google Maps
  Future<void> _openInMaps(String address) async {
    final encoded = Uri.encodeComponent(address);
    final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$encoded");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 Daftar mitra koperasi
    final Map<String, List<Map<String, String>>> partners = {
      "Koperasi Mahasiswa": [
        {
          "name": "Panda Laundry",
          "image": "assets/images/panda.png",
          "address": "Jl. Banjarsari Selatan No.12, Tembalang",
          "hours": "09.00–21.00 WIB"
        },
        {
          "name": "Gajah Print",
          "image": "assets/images/gajah.png",
          "address": "Jl. Ngesrep Timur V No.20, Banyumanik",
          "hours": "10.00–20.00 WIB"
        },
                {
          "name": "Annida Station",
          "image": "assets/images/annida.png",
          "address": "Jl. Timoho Barat No.2, Tembalang",
          "hours": "08.30–20.00 WIB"
        },
      ],
      "Koperasi IKA": [
        {
          "name": "Temcit Chicken",
          "image": "assets/images/temcit.png",
          "address": "Jl. Gondang Raya No.17, Bulusan",
          "hours": "09.00–21.00 WIB"
        },
        {
          "name": "Burjo Pantry",
          "image": "assets/images/pantry.png",
          "address": "Jl. Tirto Agung No.5, Tembalang",
          "hours": "08.00–22.00 WIB"
        },
        {
          "name": "Frezzo Powder",
          "image": "assets/images/frezzo.png",
          "address": "Jl. Ngesrep Timur V No.20, Banyumanik",
          "hours": "10.00–20.00 WIB"
        },
      ],
      "Koperasi Polines": [
        {
          "name": "Kopi Kemenangan",
          "image": "assets/images/kopi.png",
          "address": "Jl. Soekarno-Hatta No.2, Polines Area",
          "hours": "07.00–19.00 WIB"
        },
        {
          "name": "Kosan Kampus",
          "image": "assets/images/kosan.png",
          "address": "Jl. Sendangmulyo Timur No.14, Tembalang",
          "hours": "07.00–22.00 WIB"
        },
        {
          "name": "Stasiun Computer",
          "image": "assets/images/stasiun.png",
          "address": "Jl. Sendangmulyo Timur No.22, Tembalang",
          "hours": "07.00–22.00 WIB"
        },
      ],
    };

    final mitraList = partners[koperasi.name] ?? [];

    // 🔹 Alamat koperasi utama
    final Map<String, String> koperasiAddress = {
      "Koperasi Mahasiswa": "Gedung SA I, Polines – Tembalang, Semarang",
      "Koperasi IKA": "GKT Lt.2, Polines - Tembalang, Semarang",
      "Koperasi Polines": "Gedung Rektorat Lt.1, Polines - Tembalang, Semarang",
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF2F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(
          koperasi.name,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          // 🔹 Background dekoratif
          Positioned(
            top: -120,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                color: Color(0xFFCCE7E7),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -80,
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
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      koperasi.image,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Nama + alamat koperasi
                Center(
                  child: Column(
                    children: [
                      Text(
                        koperasi.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        koperasiAddress[koperasi.name] ?? "Alamat tidak tersedia",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Deskripsi koperasi
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    koperasi.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  "Mitra Koperasi",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),

                // 🔹 Grid mitra
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mitraList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final mitra = mitraList[index];
                    return GestureDetector(
                      onTap: () {
                        // 🔹 Popup detail mitra
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Text(
                              mitra["name"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  mitra["image"]!,
                                  height: 80,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  mitra["address"] ?? "Alamat tidak tersedia",
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.access_time, size: 16, color: Colors.teal),
                                    const SizedBox(width: 4),
                                    Text(
                                      mitra["hours"] ?? "Jam buka tidak tersedia",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              TextButton(
                                onPressed: () => _openInMaps(mitra["address"] ?? ""),
                                child: const Text("📍 Buka di Maps"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Tutup"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
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
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    mitra["image"]!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              mitra["name"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
