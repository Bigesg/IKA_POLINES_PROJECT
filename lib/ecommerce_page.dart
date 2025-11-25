import 'package:flutter/material.dart';
import 'ecommerce_detail_page.dart';

class EcommercePage extends StatelessWidget {
  EcommercePage({super.key});

  // MAP TANPA MODEL
  final List<Map<String, dynamic>> koperasiList = [
    {
      "name": "Koperasi Mahasiswa",
      "image": "assets/images/kopma.png",
      "updated": "Updated today",
      "description":
          "Koperasi Mahasiswa Polines melayani kebutuhan harian mahasiswa.",
      "mitra": [
        {
          "name": "Panda Laundry",
          "image": "assets/images/panda.png",
          "address": "Jl. Pekunden Tengah No.1041a, Semarang Tengah",
          "hours": "08.00–21.00"
        },
        {
          "name": "Kosan Kampus",
          "image": "assets/images/kosan.png",
          "address": "Jl. Banjarsari Selatan No.5, Pedalangan",
          "hours": "24 Jam"
        },
      ]
    },
    {
      "name": "Koperasi IKA",
      "image": "assets/images/ika.png",
      "updated": "Updated yesterday",
      "description":
          "Koperasi IKA menaungi produk dan usaha alumni POLINES, mendukung jejaring bisnis antar alumni.",
      "mitra": [
        {
          "name": "Burjo Pantry",
          "image": "assets/images/pantry.png",
          "address": "Jl. Dr. Kariadi No.80, Semarang Selatan",
          "hours": "24 Jam"
        },
        {
          "name": "Frezzo Powder",
          "image": "assets/images/frezzo.png",
          "address": "Jl. Lamongan IX No.1, Gajahmungkur",
          "hours": "10.00–16.30"
        },
        {
          "name": "Dydy Kitchen",
          "image": "assets/images/dydy.png",
          "address": "Jl. Bukit Agung, Banyumanik",
          "hours": "09.30–19.00"
        },
      ]
    },
    {
      "name": "Koperasi Polines",
      "image": "assets/images/polines.png",
      "updated": "Updated 2 days ago",
      "description":
          "Koperasi Polines merupakan unit resmi yang dinaungi oleh Polines.",
      "mitra": [
        {
          "name": "Gajah Print",
          "image": "assets/images/gajah.png",
          "address": "Jl. Gajah Raya No.10",
          "hours": "08.00–00.00"
        },
        {
          "name": "Stasiun Komputer",
          "image": "assets/images/stasiun.png",
          "address": "Jl. KH. Sirojudin No.14, Tembalang",
          "hours": "10.00–21.00"
        },
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F8F8),
      appBar: AppBar(
        title: const Text(
          "E-Commerce Koperasi",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER IMAGE
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/ika.png",
                  width: double.infinity,
                  height: screenWidth * 0.45,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const Text(
              "IKA POLINES PARTNER",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            const Text(
              "GKT Lt. 2, Ruang 202, Politeknik Negeri Semarang",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // GRID LIST
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: koperasiList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (_, index) {
                  final data = koperasiList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EcommerceDetailPage(koperasi: data),
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
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(data["image"], height: 60),
                          const SizedBox(height: 8),
                          Text(
                            data["name"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            data["updated"],
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 11),
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
      ),
    );
  }
}
