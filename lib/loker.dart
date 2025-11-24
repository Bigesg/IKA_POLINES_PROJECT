import 'dart:convert';
import 'package:flutter/material.dart';
import 'job_detail.dart';
import 'background_decor.dart';
import 'package:http/http.dart' as http;

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  List jobs = [];
  bool isLoading = true;
  String selectedSort = "newest";
  String? _hoveredSort;

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      final url = Uri.parse("http://127.0.0.1:8000/api/loker"); // Ganti sesuai kebutuhan
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          jobs = json.decode(response.body);
          isLoading = false;
        });
      } else {
        print("Gagal mengambil data: ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0EF),
      appBar: AppBar(
        title: const Text("Available Jobs"),
        backgroundColor: const Color(0xFF1E5A5D),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BackgroundDecor(
        type: 'Bold',
        child: SafeArea(
          child: Stack(
            children: [
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : jobs.isEmpty
                      ? const Center(
                          child: Text(
                            "Tidak ada data loker",
                            style: TextStyle(color: Colors.black87, fontSize: 16),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SORT DROPDOWN
                              Padding(
                                padding: const EdgeInsets.only(right: 16, bottom: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MouseRegion(
                                      onEnter: (_) => setState(() => _hoveredSort = 'dropdown'),
                                      onExit: (_) => setState(() => _hoveredSort = null),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: _hoveredSort == 'dropdown'
                                              ? const Color(0xFF0277BD)
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: selectedSort,
                                            dropdownColor: Colors.white,
                                            iconEnabledColor: _hoveredSort == 'dropdown'
                                                ? Colors.white
                                                : const Color(0xFF004D40),
                                            style: TextStyle(
                                              color: _hoveredSort == 'dropdown'
                                                  ? Colors.white
                                                  : const Color(0xFF004D40),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            items: [
                                              DropdownMenuItem(
                                                value: 'newest',
                                                child: Text("Newest",
                                                    style: TextStyle(
                                                      color: const Color(0xFF004D40),
                                                    )),
                                              ),
                                              DropdownMenuItem(
                                                value: 'latest',
                                                child: Text("Latest",
                                                    style: TextStyle(
                                                      color: const Color(0xFF004D40),
                                                    )),
                                              ),
                                            ],
                                            onChanged: (value) {
                                              setState(() => selectedSort = value!);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // LIST JOBS
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                child: Column(
                                  children: jobs.map((job) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 14),
                                      padding: const EdgeInsets.all(14),
                                      width: screenWidth * 0.92,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFF1B4D4A),
                                            Color(0xFF2A6B66),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // COMPANY
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(6),
                                                child: Image.network(
                                                  "http://10.0.2.2:8000/${job['gambar'] ?? ''}",
                                                  height: 36,
                                                  width: 36,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) => Image.asset(
                                                    'assets/images/default.png',
                                                    height: 36,
                                                    width: 36,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  job['perusahaan']['nama_perusahaan'] ?? "-",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),

                                          // POSITION
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF517E7B),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              job['judul_loker'] ?? "-",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 6),

                                          // LOCATION + DATE
                                          Wrap(
                                            spacing: 10,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(Icons.location_on,
                                                      size: 14, color: Colors.white),
                                                  const SizedBox(width: 3),
                                                  Text(job['lokasi'] ?? "-",
                                                      style: const TextStyle(
                                                          color: Colors.white, fontSize: 11)),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(Icons.calendar_today,
                                                      size: 14, color: Colors.white),
                                                  const SizedBox(width: 3),
                                                  Text(job['tanggal'] ?? "-",
                                                      style: const TextStyle(
                                                          color: Colors.white, fontSize: 11)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),

                                          // DESCRIPTION
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF517E7B),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              job['deskripsi_loker'] ?? "-",
                                              style: const TextStyle(
                                                  color: Colors.white, fontSize: 12, height: 1.3),
                                            ),
                                          ),
                                          const SizedBox(height: 8),

                                          // BUTTON DETAIL
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(221, 2, 92, 77),
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 22, vertical: 10),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => JobDetailPage(
                                                      company: job['perusahaan']
                                                              ['nama_perusahaan'] ??
                                                          "-",
                                                      position: job['judul_loker'] ?? "-",
                                                      location: job['lokasi'] ?? "-",
                                                      tags: List<String>.from(job['tags'] ?? []),
                                                      image: "http://10.0.2.2:8000/${job['gambar'] ?? ''}",
                                                      headerImage: "http://10.0.2.2:8000/${job['header_image'] ?? ''}",
                                                      applyUrl: job['apply_url'] ?? "-",
                                                      mapsUrl: job['maps_url'] ?? "-",
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "Detail",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
