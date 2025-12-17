import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// =======================================================
// >>> LANGKAH PENTING: TAMBAHKAN IMPORT KE FILE JOB_DETAIL.DART <<<
// Pastikan nama file dan path di bawah ini sudah benar:
import 'job_detail.dart'; 
// =======================================================


// --- Warna Hijau Tosca yang Digunakan ---
// Saya akan menggunakan warna Teal sebagai representasi Hijau Tosca
const Color toscaPrimary = Colors.teal;
const Color toscaLight = Color.fromARGB(255, 178, 223, 219); // Teal.shade100
const Color toscaChipBg = Color.fromARGB(255, 204, 235, 233); // Teal.shade50
const Color toscaChipBorder = Color.fromARGB(255, 128, 203, 196); // Teal.shade200

// ---------------------------------------------------------------------------------
// >>> BAGIAN INI SUDAH DIHAPUS DAN DIGANTI DENGAN IMPORT 'job_detail.dart' DI ATAS <<<
// class JobDetailPage extends StatelessWidget { ... } // DIHAPUS
// class BackgroundDecor extends StatelessWidget { ... } // DIHAPUS
// ---------------------------------------------------------------------------------


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
  bool _isSortingVisible = false; // State untuk mengontrol visibilitas sort

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  static const String serverBase = 'http://127.0.0.1:8000';

  String? resolveImageUrl(String? url) {
    if (url == null || url.isEmpty) return null;
    var u = url;
    if (u.startsWith('http')) {
      if (kIsWeb) u = u.replaceFirst('127.0.0.1', 'localhost');
      return u;
    }
    if (!u.startsWith('/')) u = '/$u';
    if (kIsWeb) return serverBase.replaceFirst('127.0.0.1', 'localhost') + u;
    // non-web (emulator/device) use emulator host so Android emulator can reach host
    return serverBase.replaceFirst('127.0.0.1', '10.0.2.2') + u;
  }

  Future<void> fetchJobs() async {
    setState(() => isLoading = true);
    try {
      final url = Uri.parse("http://127.0.0.1:8000/api/loker"); // Ganti sesuai kebutuhan
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          jobs = json.decode(response.body);
          _sortJobs(selectedSort); // Terapkan sorting awal
          isLoading = false;
        });
      } else {
        if (kDebugMode) {
          print("Gagal mengambil data: ${response.statusCode}");
        }
        setState(() => isLoading = false);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      setState(() => isLoading = false);
    }
  }

  void _sortJobs(String sortKey) {
    if (jobs.isEmpty) return;
    if (sortKey == 'newest') {
      // Sorting: dari data terbaru ke terlama
      jobs.sort((a, b) {
        final aDate = a['created_at'] != null ? DateTime.tryParse(a['created_at']) : null;
        final bDate = b['created_at'] != null ? DateTime.tryParse(b['created_at']) : null;

        if (aDate == null && bDate == null) return 0;
        if (aDate == null) return 1;
        if (bDate == null) return -1;
        return bDate.compareTo(aDate);
      });
    } else if (sortKey == 'oldest') {
      // Sorting: dari data terlama ke terbaru
      jobs.sort((a, b) {
        final aDate = a['created_at'] != null ? DateTime.tryParse(a['created_at']) : null;
        final bDate = b['created_at'] != null ? DateTime.tryParse(b['created_at']) : null;

        if (aDate == null && bDate == null) return 0;
        if (aDate == null) return 1;
        if (bDate == null) return -1;
        return aDate.compareTo(bDate);
      });
    }
  }

  void _navigateToJobDetail(Map job) {
    // Fungsi ini sekarang memanggil JobDetailPage dari file 'job_detail.dart'
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => JobDetailPage(
          company: job['perusahaan']['nama_perusahaan'] ?? "-",
          position: job['judul_loker'] ?? "-",
          location: job['lokasi'] ?? job['perusahaan']?['lokasi'] ?? "-",
          tags: List<String>.from(job['tags'] ?? []),
          image: resolveImageUrl(job['gambar']) ?? '',
          headerImage: resolveImageUrl(job['header_image']) ?? '',
          applyUrl: job['apply_url'] ?? "-",
          mapsUrl: job['maps_url'] ?? "-",
          companyLogo: resolveImageUrl(job['perusahaan']?['logo']),
          rating: job['perusahaan']?['rating']?.toString(),
          tentangKami: job['perusahaan']?['tentang_kami'],
          visi: job['perusahaan']?['visi'],
          misi: job['perusahaan']?['misi'],
          deskripsiPekerjaan: job['deskripsi_pekerjaan'],
          jobRequirement: job['job_requirement'],
          requiredSkill: job['required_skill'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Fungsionalitas Tombol Kembali ke menu sebelumnya (pop)
            Navigator.pop(context);
          },
        ),
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // Toggle visibilitas dropdown sort/filter
              setState(() {
                _isSortingVisible = !_isSortingVisible;
              });
            },
          ),
        ],
      ),
      // MENGHILANGKAN BackgroundDecor agar tampilan lebih bersih
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 5.0),
              child: Text(
                'JOBS',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                  color: Colors.black,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Row(
                children: [
                  Icon(
                    Icons.rocket_launch,
                    color: Colors.deepOrange,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Temukan Karir Impianmu!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.grey,
            ),

            // Bagian Sort: Muncul jika _isSortingVisible true
            if (_isSortingVisible)
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildSortDropdown(),
                  ],
                ),
              ),
            
            // --- LIST JOBS ---
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : jobs.isEmpty
                      ? const Center(
                            child: Text(
                              "Tidak ada data loker",
                              style: TextStyle(color: Colors.black87, fontSize: 16),
                            ),
                          )
                      : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            itemCount: jobs.length,
                            itemBuilder: (context, index) {
                              final job = jobs[index];
                              // JobCard memanggil _navigateToJobDetail yang sudah diperbaiki
                              return JobCard(
                                job: job,
                                resolveImageUrl: resolveImageUrl,
                                onTapDetail: () => _navigateToJobDetail(job),
                              );
                            },
                          ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar Dihilangkan sesuai permintaan
      // bottomNavigationBar: const CustomBottomNavBar(), 
    );
  }

  // Widget Dropdown Sort
  Widget _buildSortDropdown() {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredSort = 'dropdown'),
      onExit: (_) => setState(() => _hoveredSort = null),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: toscaPrimary, width: 1.0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedSort,
            dropdownColor: Colors.white,
            icon: const Icon(Icons.keyboard_arrow_down, color: toscaPrimary),
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            items: const [
              DropdownMenuItem(
                value: 'newest',
                child: Text("Terbaru"),
              ),
              DropdownMenuItem(
                value: 'oldest',
                child: Text("Terlama"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedSort = value!;
                _sortJobs(selectedSort);
              });
            },
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------
// --- KOMPONEN UI TAMBAHAN ---
// ------------------------------------------

class JobCard extends StatelessWidget {
  final Map job;
  final String? Function(String?) resolveImageUrl;
  final VoidCallback onTapDetail;

  const JobCard({
    super.key,
    required this.job,
    required this.resolveImageUrl,
    required this.onTapDetail,
  });

  String _formatDate(String? date) {
    if (date == null) return "-";
    try {
      final DateTime jobDate = DateTime.parse(date);
      final Duration difference = DateTime.now().difference(jobDate);
      if (difference.inDays > 0) {
        return '${difference.inDays} hari yang lalu';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} jam yang lalu';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} menit yang lalu';
      } else {
        return 'Baru saja';
      }
    } catch (e) {
      return date.split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final String companyName = job['perusahaan']?['nama_perusahaan'] ?? "-";
    final String location = job['lokasi'] ?? job['perusahaan']?['lokasi'] ?? "-";
    final String role = job['judul_loker'] ?? "-";
    final String imageUrl = resolveImageUrl(job['perusahaan']?['logo'] ?? job['gambar']) ?? '';
    final String timeAgo = _formatDate(job['created_at']?.toString() ?? job['tanggal']);


    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo Perusahaan (Menggunakan Image.network dengan fallback)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imageUrl,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Center(
                        child: Icon(Icons.business, color: Colors.blueGrey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              location,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Tombol Role/Posisi (Hijau Tosca)
                Chip(
                  label: Text(
                    role,
                    style: const TextStyle(
                      color: toscaPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: toscaChipBg,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: toscaChipBorder, width: 0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  timeAgo,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                // Teks 'Detail' (Hijau Tosca) dan fungsi onTap
                GestureDetector(
                  onTap: onTapDetail,
                  child: const Text(
                    'Detail',
                    style: TextStyle(
                      fontSize: 14,
                      color: toscaPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}