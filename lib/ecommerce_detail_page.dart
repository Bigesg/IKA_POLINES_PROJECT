import 'package:flutter/material.dart';
import '../models/koperasi_model.dart';

class EcommerceDetailPage extends StatelessWidget {
  final Koperasi koperasi;

  const EcommerceDetailPage({super.key, required this.koperasi});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> partners = [
      {"name": "Temcit Chicken", "image": "assets/images/temcit.png"},
      {"name": "Dydy Kitchen", "image": "assets/images/dydy.png"},
      {"name": "Frezzo Powder", "image": "assets/images/frezzo.png"},
      {"name": "Kosan Kampus", "image": "assets/images/kosan.png"},
      {"name": "Panda Laundry", "image": "assets/images/panda.png"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(koperasi.name),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(koperasi.image, height: 120)),
            const SizedBox(height: 16),
            Text(
              koperasi.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.access_time, size: 18, color: Colors.blueGrey),
                SizedBox(width: 6),
                Text("Buka Senin–Jumat, 10.00–16.00"),
              ],
            ),
            const Row(
              children: [
                Icon(Icons.location_on, size: 18, color: Colors.blueGrey),
                SizedBox(width: 6),
                Text("Gedung SA I - Polines, Tembalang"),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              koperasi.description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              "Mitra Koperasi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Grid mitra koperasi
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: partners.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final partner = partners[index];
                return Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          partner["image"]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      partner["name"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
