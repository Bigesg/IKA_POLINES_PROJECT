import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'utils/api_helper.dart';
import 'package:http/http.dart' as http;
import 'ecommerce_detail_page.dart';

class EcommercePage extends StatefulWidget {
  const EcommercePage({super.key});

  @override
  State<EcommercePage> createState() => _EcommercePageState();
}

class _EcommercePageState extends State<EcommercePage> {
  List<dynamic> koperasiList = [];
  bool isLoading = true;
  bool isError = false;
  static String get baseApiUrl => ApiHelper.apiUrl('/api/galeri');

  @override
  void initState() {
    super.initState();
    fetchKoperasi();
  }

  Future<void> fetchKoperasi() async {
    try {
      final response = await http.get(Uri.parse(baseApiUrl));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // debug: print small portion of response and foto fields
        // ignore: avoid_print
        print('fetchKoperasi: response length=${response.body.length}');
        try {
          // ignore: avoid_print
          print('fetchKoperasi sample: ${response.body.length > 500 ? response.body.substring(0, 500) + "..." : response.body}');
        } catch (_) {}
        final list = jsonData['data'] ?? [];
        for (var item in list) {
          // ignore: avoid_print
          print('item foto raw: ${item["foto"]}');
        }
        setState(() {
          koperasiList = list;
          isLoading = false;
        });
      } else {
        isError = true;
        isLoading = false;
        setState(() {});
      }
    } catch (e) {
      isError = true;
      isLoading = false;
      setState(() {});
    }
  }

  /// Widget gambar AMAN (tidak crash & tidak double URL)
  Widget buildImage(String? url) {
    if (url == null || url.isEmpty) {
      return const Icon(Icons.image_not_supported, size: 60);
    }

    // jika URL lengkap (http/https) gunakan network image
    if (url.startsWith('http')) {
      return Image.network(
        url,
        height: 60,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const SizedBox(
            height: 60,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        },
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 60),
      );
    }

    // jika path aset lokal diberikan
    if (url.contains('assets/') || url.contains('asset/')) {
      try {
        return Image.asset(url, height: 60, fit: BoxFit.contain);
      } catch (_) {
        return const Icon(Icons.broken_image, size: 60);
      }
    }

    // fallback: tampilkan ikon, karena URL bukan http dan bukan asset
    return const Icon(Icons.broken_image, size: 60);
  }

  /// Normalisasi URL gambar: tambahkan host jika path relatif,
  /// dan sesuaikan host lokal untuk environment (web vs emulator).
  String? resolveImageUrl(String? url) => ApiHelper.resolveImageUrl(url);

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isError
              ? const Center(child: Text("Gagal memuat data dari server"))
              : SingleChildScrollView(
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.9,
                          ),
                          itemBuilder: (_, index) {
                            final data = koperasiList[index];
                            final resolved = resolveImageUrl(data["foto"]);
                            // debug: lihat URL yang akan dimuat
                            // (akan muncul di console saat debugging)
                            // ignore: avoid_print
                            print('resolved image url: $resolved');

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EcommerceDetailPage(
                                      koperasiId: data["id"],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
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
                                    buildImage(resolved),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        data["judul"] ?? "-",
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      data["updated_at"] ?? "",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11,
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
                ),
    );
  }
}
