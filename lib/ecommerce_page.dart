import 'dart:convert';
import 'package:flutter/material.dart';
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
  String? errorMessage;
  static String get baseApiUrl => ApiHelper.apiUrl('/galeri');

  @override
  void initState() {
    super.initState();
    fetchKoperasi();
  }

  Future<void> fetchKoperasi() async {
    try {
      // ignore: avoid_print
      print("🔄 Fetching from: $baseApiUrl");

      final response = await http.get(Uri.parse(baseApiUrl)).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception("Request timeout - Server tidak merespons"),
      );

      // ignore: avoid_print
      print("📊 Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // ignore: avoid_print
        print("✅ Response received, data count: ${jsonData['data']?.length ?? 0}");

        final list = (jsonData['data'] ?? []) as List;

        for (var item in list) {
          // ignore: avoid_print
          print("📷 Item foto: ${item["foto"]}");
        }

        setState(() {
          koperasiList = list;
          isLoading = false;
          isError = false;
        });
      } else {
        // ignore: avoid_print
        print("❌ Status code: ${response.statusCode}, Body: ${response.body}");
        setState(() {
          isError = true;
          isLoading = false;
          errorMessage = "Server error: ${response.statusCode}";
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print("❌ Error: $e");
      setState(() {
        isError = true;
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  /// Widget gambar AMAN (tidak crash & tidak double URL)
  Widget buildImage(String? url) {
    if (url == null || url.isEmpty) {
      return const Icon(Icons.image_not_supported, size: 60);
    }

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

    if (url.contains('assets/') || url.contains('asset/')) {
      try {
        return Image.asset(url, height: 60, fit: BoxFit.contain);
      } catch (_) {
        return const Icon(Icons.broken_image, size: 60);
      }
    }

    return const Icon(Icons.broken_image, size: 60);
  }

  /// Normalisasi URL gambar
  String? resolveImageUrl(String? url) => ApiHelper.resolveImageUrl(url);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F8F8),
      appBar: AppBar(
        title: const Text(
          "Galeri Bisnis Alumni",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isError
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.wifi_off, size: 60, color: Colors.red),
                        const SizedBox(height: 16),
                        const Text(
                          "Gagal memuat data dari server",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          errorMessage ?? "Unknown error",
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: fetchKoperasi,
                          icon: const Icon(Icons.refresh),
                          label: const Text("Coba Lagi"),
                        ),
                      ],
                    ),
                  ),
                )
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
                        "Galeri Bisnis Alumni Polines",
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
                            final data = (koperasiList[index] as Map).cast<String, dynamic>();
                            final resolved = resolveImageUrl(data["foto"]?.toString());

                            // ignore: avoid_print
                            print('resolved image url: $resolved');

                            return GestureDetector(
                              onTap: () {
                                final rawId = data["id"];
                                final id = int.tryParse(rawId.toString());

                                // ignore: avoid_print
                                print("👉 Tap koperasi id: $rawId | parsed: $id");

                                if (id == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("ID koperasi kosong/tidak valid")),
                                  );
                                  return;
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EcommerceDetailPage(
                                      koperasiId: id,
                                      koperasiData: data, // <-- penting: kirim data awal
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
                                        (data["judul"] ?? data["name"] ?? "-").toString(),
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
                                      (data["updated_at"] ?? "").toString(),
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
