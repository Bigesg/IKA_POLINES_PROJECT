import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LokerPage(),
    );
  }
}

// ===============================
// Halaman Loker (UI utama)
// ===============================
class LokerPage extends StatelessWidget {
  const LokerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F3A3D),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "GAMBAR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF5C7D7E),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "FIND JOBS HERE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sort dropdown
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5C7D7E),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: "new/late",
                    dropdownColor: const Color(0xFF5C7D7E),
                    underline: const SizedBox(),
                    iconEnabledColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    items: const [
                      DropdownMenuItem(value: "new/late", child: Text("Sort by: new/late")),
                      DropdownMenuItem(value: "late/new", child: Text("Sort by: late/new")),
                    ],
                    onChanged: (_) {},
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Job cards
              const JobCard(
                company: "COMPANY A",
                position: "SOFTWARE ENGINEER",
                location: "SMR",
                type: "FULL-TIME",
                daysAgo: "3 day ago",
                description:
                    "Join Company A as a Software Engineer in Semarang! We're looking for innovative minds to build and optimize software solutions that drive real-world impact.",
              ),
              const JobCard(
                company: "COMPANY B",
                position: "PRODUCT DESIGNER",
                location: "JKT",
                type: "FULL-TIME",
                daysAgo: "5 day ago",
                description:
                    "Join Company B as a Product Designer in Jakarta! We're looking for innovative minds to build and optimize software solutions that drive real-world impact.",
              ),
              const JobCard(
                company: "COMPANY C",
                position: "SOFTWARE ENGINEER",
                location: "SMR",
                type: "PART-TIME",
                daysAgo: "10 day ago",
                description:
                    "Join Company C as a Part-Time Content Creator in Semarang! Create engaging content, work with a great team, and grow your skills with flexible hours.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===============================
// Widget Kartu Lowongan
// ===============================
class JobCard extends StatelessWidget {
  final String company;
  final String position;
  final String location;
  final String type;
  final String daysAgo;
  final String description;

  const JobCard({
    super.key,
    required this.company,
    required this.position,
    required this.location,
    required this.type,
    required this.daysAgo,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2F4F50),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo + Nama Perusahaan + Posisi
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                color: const Color(0xFF5C7D7E),
                alignment: Alignment.center,
                child: const Text(
                  "LOGO",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5C7D7E),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        position,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Baris info lokasi, jenis, tanggal
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.white.withOpacity(0.8), size: 14),
              const SizedBox(width: 4),
              Text(location, style: const TextStyle(color: Colors.white, fontSize: 12)),
              const SizedBox(width: 12),
              Icon(Icons.access_time, color: Colors.white.withOpacity(0.8), size: 14),
              const SizedBox(width: 4),
              Text(type, style: const TextStyle(color: Colors.white, fontSize: 12)),
              const Spacer(),
              Icon(Icons.calendar_today, color: Colors.white.withOpacity(0.8), size: 14),
              const SizedBox(width: 4),
              Text(daysAgo, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),

          // Deskripsi pekerjaan
          Text(
            description,
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
