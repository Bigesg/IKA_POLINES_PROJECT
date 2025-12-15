import 'dart:convert';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    fetchKoperasi();
  }

  Future<void> fetchKoperasi() async {
    try {
      final response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/galeri"), 
        // GANTI dengan IP & endpoint Laravel milikmu
      );

      if (response.statusCode == 200) {
        setState(() {
          koperasiList = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

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

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EcommerceDetailPage(koperasiId: data["id"]),
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
                                    data["image_url"] != null
                                        ? Image.network(
                                            data["image_url"],
                                            height: 60,
                                            errorBuilder: (_, __, ___) =>
                                                const Icon(Icons.image),
                                          )
                                        : Image.asset(
                                            "assets/images/ika.png",
                                            height: 60,
                                          ),
                                    const SizedBox(height: 8),
                                    Text(
                                      data["name"] ?? "-",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      data["updated"] ?? "",
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
