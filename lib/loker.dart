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
        "logo": "assets/Google.jpg",
        "position": "Software Engineer",
        "location": "SMR",
        "type": "Full-Time",
        "days": "3 day ago",
        "description":
            "Join Google as a Software Engineer in Semarang! We're looking for innovative minds to build and optimize software solutions that drive real-world impact.",
        "isGoogle": true,
      },
      {
        "company": "Company B",
        "logo": "assets/logo.jpg",
        "position": "Product Designer",
        "location": "JKT",
        "type": "Full-Time",
        "days": "5 day ago",
        "description":
            "Join Company B as a Product Designer in Jakarta! We're looking for innovative minds to build and optimize software solutions that drive real-world impact.",
        "isGoogle": false,
      },
      {
        "company": "Company C",
        "logo": "assets/logo.jpg",
        "position": "Content Creator",
        "location": "SMR",
        "type": "Part-Time",
        "days": "10 day ago",
        "description":
            "Join Company C as a Part-Time Content Creator in Semarang! Create engaging content, work with a great team, and grow your skills with flexible hours.",
        "isGoogle": false,
      },
    ];

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
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    Image.asset("assets/logo.jpg", height: 70, width: 70),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 32),
                      decoration: BoxDecoration(
                        color: const Color(0xFF517E7B),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "FIND JOBS HERE",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: DropdownButton<String>(
                    value: selectedSort,
                    underline: Container(),
                    items: const [
                      DropdownMenuItem(
                          value: "newest", child: Text("newest")),
                      DropdownMenuItem(
                          value: "latest", child: Text("latest")),
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: jobs.map((job) {
                    return GestureDetector(
                      onTap: job['isGoogle']
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const JobDetailPage()),
                              );
                            }
                          : null,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF234F4D),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  job['logo'],
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    job['company'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
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
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    size: 14, color: Colors.white),
                                const SizedBox(width: 4),
                                Text(
                                  job['location'],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                const SizedBox(width: 12),
                                const Icon(Icons.access_time,
                                    size: 14, color: Colors.white),
                                const SizedBox(width: 4),
                                Text(
                                  job['type'],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                const SizedBox(width: 12),
                                const Icon(Icons.calendar_today,
                                    size: 14, color: Colors.white),
                                const SizedBox(width: 4),
                                Text(
                                  job['days'],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF517E7B),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                job['description'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
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
