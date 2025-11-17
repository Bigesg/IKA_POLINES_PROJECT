import 'package:flutter/material.dart';

// ================= DATA LOKER (GLOBAL) =================
// Data ini ditaruh di luar kelas agar bisa diakses oleh main.dart
final List<Map<String, dynamic>> globalJobList = [
  {
    'image': 'assets/images/loker_ui_card.png', // Pastikan aset ini ada
    'company': 'Invision',
    'position': 'UI Designer',
    'location': 'Jakarta, Indonesia - Onsite',
    'tags': ['Remote', 'Contract', 'Junior'],
    'timeAgo': '3 hari yang lalu',
    'type': 'Full-Time',
    'days': '3 days ago',
    'description':
        'Kami mencari UI Designer yang bersemangat untuk menciptakan antarmuka yang indah dan fungsional.',
  },
  {
    'image': 'assets/images/loker_marketing.png', // Pastikan aset ini ada
    'company': 'Telegram',
    'position': 'Digital Marketing',
    'location': 'Jakarta, Indonesia - Onsite',
    'tags': ['Remote', 'Fulltime'],
    'timeAgo': '3 hari yang lalu',
    'type': 'Full-Time',
    'days': '3 days ago',
    'description':
        'Bergabunglah dengan tim pemasaran kami untuk mengembangkan strategi digital yang inovatif.',
  },
  {
    'image': 'assets/images/google.jpg', // Pastikan aset ini ada
    'company': 'Google',
    'position': 'Software Engineer',
    'location': 'Semarang, Indonesia - Onsite',
    'tags': ['Fulltime', 'Senior', 'Tech'],
    'timeAgo': '1 hari yang lalu',
    'type': 'Full-Time',
    'days': '1 days ago',
    'description':
        'Membangun solusi backend yang skalabel untuk jutaan pengguna.',
  },
];
// =======================================================

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  String selectedSort = "newest";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0EF),
      body: SafeArea(
        child: Stack(
          children: [
            // Hiasan Latar
            Positioned(
              top: -80,
              left: -60,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              right: -40,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Container(
                    color: const Color(0xFF234F4D),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 26),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF517E7B),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "FIND JOBS HERE",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 8,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Dropdown
                  Container(
                    color: const Color(0xFFE8F0EF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: DropdownButton<String>(
                        value: selectedSort,
                        underline: Container(),
                        items: const [
                          DropdownMenuItem(
                            value: "newest",
                            child: Text("Newest"),
                          ),
                          DropdownMenuItem(
                            value: "latest",
                            child: Text("Latest"),
                          ),
                        ],
                        onChanged: (value) =>
                            setState(() => selectedSort = value!),
                      ),
                    ),
                  ),

                  // List Loker (Menggunakan Data Global)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: globalJobList.map((job) {
                        return _buildJobCard(context, job, screenWidth);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(
    BuildContext context,
    Map<String, dynamic> job,
    double width,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      width: width * 0.92,
      decoration: BoxDecoration(
        color: const Color(0xFF234F4D),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  job['image'],
                  width: 30,
                  height: 30,
                  errorBuilder: (c, e, s) => const Icon(Icons.work),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  job['company'],
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF517E7B),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              job['position'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 10,
            runSpacing: 4,
            children: [
              _buildIconText(
                Icons.location_on,
                job['location'].split('-')[0].trim(),
              ),
              _buildIconText(Icons.access_time, job['type']),
              _buildIconText(Icons.calendar_today, job['days']),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF517E7B),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              job['description'],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JobDetailPage(jobData: job),
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
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white),
        const SizedBox(width: 3),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 11)),
      ],
    );
  }
}

// HALAMAN DETAIL (Dipanggil dari Home dan Loker List)
class JobDetailPage extends StatelessWidget {
  final Map<String, dynamic> jobData;

  const JobDetailPage({super.key, required this.jobData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(jobData['position']),
        backgroundColor: const Color(0xFF234F4D),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  jobData['image'],
                  width: 80,
                  height: 80,
                  errorBuilder: (c, e, s) => const Icon(Icons.work, size: 60),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                jobData['position'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                "${jobData['company']} • ${jobData['location']}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              "Deskripsi Pekerjaan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              jobData['description'],
              style: const TextStyle(height: 1.5, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            const Text(
              "Persyaratan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "• Minimal pengalaman 1 tahun di bidang terkait.\n• Menguasai Figma, Adobe XD.\n• Mampu bekerja dalam tim.",
              style: TextStyle(height: 1.5, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            const Text(
              "Tags",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: (jobData['tags'] as List)
                  .map(
                    (t) => Chip(
                      label: Text(t),
                      backgroundColor: Colors.teal.shade50,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Lamar Sekarang",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
