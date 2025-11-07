import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/koperasi_model.dart';

class EcommerceDetailPage extends StatelessWidget {
  final Koperasi koperasi;
  const EcommerceDetailPage({super.key, required this.koperasi});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F8F8),
      appBar: AppBar(
        title: Text(
          koperasi.name,
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar koperasi
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: const Offset(0, 3))],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    koperasi.image,
                    width: double.infinity,
                    height: screenWidth * 0.5,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Nama & info singkat
              Center(
                child: Column(
                  children: const [
                    SizedBox(height: 0),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: const [
                    // (kalau mau info jam/lokasi statis, taruh di sini)
                  ],
                ),
              ),

              // Deskripsi
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: const Offset(0, 3))],
                ),
                child: Text(koperasi.description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, height: 1.5)),
              ),
              const SizedBox(height: 28),

              // Mitra
              const Text("Mitra Koperasi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              koperasi.mitra.isEmpty
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: const Color(0xFFEAF5F4), borderRadius: BorderRadius.circular(16)),
                      child: const Text("Belum ada mitra terdaftar untuk koperasi ini.",
                          style: TextStyle(color: Colors.black54, fontSize: 13), textAlign: TextAlign.center),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.9,
                      ),
                      itemCount: koperasi.mitra.length,
                      itemBuilder: (context, index) {
                        final mitra = koperasi.mitra[index];
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                insetPadding: const EdgeInsets.all(20),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter, end: Alignment.bottomCenter,
                                      colors: [Color(0xFFEAF5F4), Colors.white],
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(mitra["name"]!, style: const TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0E5E55))),
                                      const SizedBox(height: 12),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(mitra["image"]!, height: 90, fit: BoxFit.contain),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.location_on_outlined, color: Color(0xFF0E5E55), size: 20),
                                          const SizedBox(width: 6),
                                          Expanded(child: Text(mitra["address"] ?? "Alamat tidak tersedia",
                                            style: const TextStyle(fontSize: 14))),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time_rounded, color: Color(0xFF0E5E55), size: 20),
                                          const SizedBox(width: 6),
                                          Text("Buka: ${mitra["hours"] ?? "-"}", style: const TextStyle(fontSize: 14)),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(onPressed: () => Navigator.pop(context),
                                            child: const Text("Tutup", style: TextStyle(color: Colors.black54))),
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(0xFF0E5E55), foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                            ),
                                            icon: const Icon(Icons.map_outlined),
                                            label: const Text("Lihat di Maps"),
                                            onPressed: () async {
                                              final alamat = Uri.encodeComponent(mitra["address"] ?? "");
                                              final url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$alamat");
                                              if (await canLaunchUrl(url)) {
                                                await launchUrl(url);
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Tidak dapat membuka Maps')),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(16),
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: const Offset(0, 3))],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(mitra["image"]!, height: 60),
                                const SizedBox(height: 6),
                                Text(mitra["name"]!, textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
