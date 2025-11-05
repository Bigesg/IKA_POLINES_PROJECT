import 'package:flutter/material.dart';
import 'job_detail.dart';

void main() {
  runApp(const JobApp());
}

class JobApp extends StatelessWidget {
  const JobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IKA Polines',
      home: const JobListPage(),
    );
  }
}

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  String selectedSort = "newest";

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> jobs = [
      {
        "company": "Google",
        "logo": "assets/images/google.jpg",
        "position": "Software Engineer",
        "location": "SMR",
        "type": "Full-Time",
        "days": "3 days ago",
        "description":
            "Join Google as a Software Engineer in Semarang! We're looking for innovative minds to build and optimize software solutions that drive real-world impact.",
        "isGoogle": true,
      },
      {
        "company": "Company B",
        "logo": "assets/images/logo.jpg",
        "position": "Product Designer",
        "location": "JKT",
        "type": "Full-Time",
        "days": "5 days ago",
        "description":
            "Join Company B as a Product Designer in Jakarta! We're looking for innovative minds to build and optimize software solutions that drive real-world impact.",
        "isGoogle": false,
      },
      {
        "company": "Company C",
        "logo": "assets/images/logo.jpg",
        "position": "Content Creator",
        "location": "SMR",
        "type": "Part-Time",
        "days": "10 days ago",
        "description":
            "Join Company C as a Part-Time Content Creator in Semarang! Create engaging content, work with a great team, and grow your skills with flexible hours.",
        "isGoogle": false,
      },
    ];

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F0EF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Container(
                color: const Color(0xFF234F4D),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Image.asset("assets/images/logo.jpg",
                        height: 60, width: 60),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
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
                  ],
                ),
              ),

              // DROPDOWN SORT
              Container(
                color: const Color(0xFFE8F0EF),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: DropdownButton<String>(
                    value: selectedSort,
                    underline: Container(),
                    items: const [
                      DropdownMenuItem(value: "newest", child: Text("Newest")),
                      DropdownMenuItem(value: "latest", child: Text("Latest")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedSort = value!;
                      });
                    },
                  ),
                ),
              ),

              // JOB LIST
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: jobs.map((job) {
                    return GestureDetector(
                      onTap: job['isGoogle']
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => JobDetailPage(),
                                ),
                              );
                            }
                          : null,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(14),
                        width: screenWidth * 0.92, // sesuai ukuran HP
                        decoration: BoxDecoration(
                          color: const Color(0xFF234F4D),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // HEADER PERUSAHAAN
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    job['logo'],
                                    height: 36,
                                    width: 36,
                                    fit: BoxFit.cover,
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

                            // POSISI
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
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

                            // INFO LOKASI, WAKTU, TIPE
                            Wrap(
                              spacing: 10,
                              runSpacing: 4,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.location_on,
                                        size: 14, color: Colors.white),
                                    const SizedBox(width: 3),
                                    Text(job['location'],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 11)),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.access_time,
                                        size: 14, color: Colors.white),
                                    const SizedBox(width: 3),
                                    Text(job['type'],
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
                                    Text(job['days'],
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 11)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // DESKRIPSI
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF517E7B),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                job['description'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    height: 1.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
