import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'utils/api_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class EcommerceDetailPage extends StatefulWidget {
  final int koperasiId;
  final Map<String, dynamic>? koperasiData;

  const EcommerceDetailPage({
    super.key,
    required this.koperasiId,
    this.koperasiData,
  });

  @override
  State<EcommerceDetailPage> createState() => _EcommerceDetailPageState();
}

class _EcommerceDetailPageState extends State<EcommerceDetailPage> {
  late Future<Map<String, dynamic>> koperasiFuture;

  @override
  void initState() {
    super.initState();
    koperasiFuture = fetchKoperasiDetail(widget.koperasiId);
  }

  String? resolveImageUrl(String? url) => ApiHelper.resolveImageUrl(url);

  Future<Map<String, dynamic>> fetchKoperasiDetail(int id) async {
    final apiUrl = ApiHelper.apiUrl('/galeri/$id');
    // ignore: avoid_print
    print("📥 Fetching detail from: $apiUrl");

    final response = await http.get(Uri.parse(apiUrl)).timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw Exception("Request timeout"),
    );

    // ignore: avoid_print
    print("📊 Response status: ${response.statusCode}");

    if (response.statusCode != 200) {
      throw Exception("Server error: ${response.statusCode}");
    }

    final raw = jsonDecode(response.body);
    // ignore: avoid_print
    print("📦 DETAIL RAW: $raw");

    dynamic payload = raw;

    if (raw is Map && raw.containsKey('data')) {
      payload = raw['data'];
    }

    if (payload is List) {
      if (payload.isEmpty) throw Exception("Detail kosong");
      payload = payload.first;
    }

    if (payload is! Map<String, dynamic>) {
      throw Exception("Format detail tidak dikenali: ${payload.runtimeType}");
    }

    return payload;
  }

  String _getString(Map<String, dynamic> m, List<String> keys, {String fallback = "-"}) {
    for (final k in keys) {
      final v = m[k];
      if (v != null && v.toString().trim().isNotEmpty) return v.toString();
    }
    return fallback;
  }

  List _getList(Map<String, dynamic> m, List<String> keys) {
    for (final k in keys) {
      final v = m[k];
      if (v is List) return v;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final initial = widget.koperasiData ?? <String, dynamic>{};
    final initialJudul = _getString(initial, ["judul", "name"], fallback: "Detail");
    final initialFoto = _getString(initial, ["foto", "image"], fallback: "");
    final initialDeskripsi = _getString(initial, ["deskripsi", "description"], fallback: "-");

    return FutureBuilder<Map<String, dynamic>>(
      future: koperasiFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: const Color(0xFFF2F8F8),
            appBar: AppBar(
              title: Text(
                initialJudul,
                style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.black87),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 50, color: Colors.red),
                    const SizedBox(height: 12),
                    Text(
                      "Gagal memuat detail:\n${snapshot.error}",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          koperasiFuture = fetchKoperasiDetail(widget.koperasiId);
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text("Coba Lagi"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          // loading: tampilkan data awal agar tidak blank
          return _buildScaffold(
            context: context,
            screenWidth: screenWidth,
            judul: initialJudul,
            foto: initialFoto,
            deskripsi: initialDeskripsi,
            mitraList: const [],
            isLoading: true,
          );
        }

        final koperasi = snapshot.data!;
        final judul = _getString(koperasi, ["judul", "name"], fallback: "Detail");
        final foto = _getString(koperasi, ["foto", "image"], fallback: "");
        final deskripsi = _getString(koperasi, ["deskripsi", "description"], fallback: "-");
        final mitraList = _getList(koperasi, ["mitra", "partners"]);

        return _buildScaffold(
          context: context,
          screenWidth: screenWidth,
          judul: judul,
          foto: foto,
          deskripsi: deskripsi,
          mitraList: mitraList,
          isLoading: false,
        );
      },
    );
  }

  Widget _buildScaffold({
    required BuildContext context,
    required double screenWidth,
    required String judul,
    required String foto,
    required String deskripsi,
    required List mitraList,
    required bool isLoading,
  }) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8F8),
      appBar: AppBar(
        title: Text(
          judul,
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
              // === GAMBAR ===
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20), // <- FIX: jangan sampai kepotong
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: (foto.trim().isEmpty)
                      ? SizedBox(
                          width: double.infinity,
                          height: screenWidth * 0.5,
                          child: const Center(
                            child: Icon(Icons.image, size: 80, color: Colors.grey),
                          ),
                        )
                      : Image.network(
                          resolveImageUrl(foto) ?? '',
                          width: double.infinity,
                          height: screenWidth * 0.5,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return SizedBox(
                              height: screenWidth * 0.5,
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            );
                          },
                          errorBuilder: (_, __, ___) => SizedBox(
                            height: screenWidth * 0.5,
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 90, color: Colors.grey),
                            ),
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              // === DESKRIPSI ===
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Text(
                  deskripsi,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ),

              const SizedBox(height: 28),

              // === MITRA TITLE ===
              Row(
                children: [
                  const Text(
                    "Mitra Koperasi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  if (isLoading) ...[
                    const SizedBox(width: 10),
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),

              // === EMPTY / GRID ===
              (mitraList.isEmpty)
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF5F4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        "Belum ada mitra terdaftar untuk koperasi ini.",
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: mitraList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (_, index) {
                        final mitra = (mitraList[index] as Map).cast<String, dynamic>();
                        final namaMitra = (mitra["name"] ?? mitra["judul"] ?? "-").toString();
                        final fotoMitra = (mitra["image"] ?? mitra["foto"] ?? "").toString();

                        return GestureDetector(
                          onTap: () => _showMitraDialog(context, mitra),
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
                                Image.network(
                                  resolveImageUrl(fotoMitra) ?? '',
                                  height: 60,
                                  fit: BoxFit.contain,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return const SizedBox(
                                      height: 60,
                                      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                    );
                                  },
                                  errorBuilder: (_, __, ___) => const Icon(Icons.store, size: 50),
                                ),
                                const SizedBox(height: 6),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    namaMitra,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
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

  void _showMitraDialog(BuildContext context, Map<String, dynamic> mitra) {
    final nama = (mitra["name"] ?? mitra["judul"] ?? "-").toString();
    final foto = (mitra["image"] ?? mitra["foto"] ?? "").toString();
    final alamat = (mitra["address"] ?? mitra["alamat"] ?? "Alamat tidak tersedia").toString();
    final jam = (mitra["hours"] ?? mitra["jam_operasional"] ?? mitra["jam_buka"] ?? "-").toString();

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
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFEAF5F4), Colors.white],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                nama,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0E5E55),
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  resolveImageUrl(foto) ?? '',
                  height: 90,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const SizedBox(
                      height: 90,
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  },
                  errorBuilder: (_, __, ___) => const Icon(Icons.store, size: 80),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on_outlined, color: Color(0xFF0E5E55), size: 20),
                  const SizedBox(width: 6),
                  Expanded(child: Text(alamat, style: const TextStyle(fontSize: 14))),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.access_time_rounded, color: Color(0xFF0E5E55), size: 20),
                  const SizedBox(width: 6),
                  Text("Buka: $jam", style: const TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Tutup", style: TextStyle(color: Colors.black54)),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.map_outlined),
                    label: const Text("Lihat di Maps"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E5E55),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () async {
                      final alamatQuery = Uri.encodeComponent(alamat);
                      final url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$alamatQuery");

                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Tidak dapat membuka Maps")),
                          );
                        }
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
  }
}
