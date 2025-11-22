import 'package:flutter/material.dart';
import 'job_detail.dart';
import 'background_decor.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  String selectedSort = "newest";
  String? _hoveredSort;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> jobs = [
      {
        "company": "Google Company",
        "logo": "assets/images/google_logo.png",
        "headerImage": "assets/images/Google.jpg",
        "position": "Software Engineer",
        "location": "Semarang",
        "days": "10/17/2025",
        "tags": ["Tech", "AI", "Cloud"],
        "applyUrl": "https://google.com",
        "mapsUrl": "https://maps.app.goo.gl/htmnM5APV6W6dKN59",
        "description":
            "Join Google as a Software Engineer in Semarang! We're looking for innovative minds to build and optimize software solutions that drive real-world impact.",
      },
      {
        "company": "Company B",
        "logo": "assets/images/companyb.jpg",
        "headerImage": "assets/images/kantor_b.jpeg",
        "position": "Product Designer",
        "location": "Jakarta",
        "days": "10/12/2025",
        "tags": ["UI/UX", "Creative"],
        "applyUrl": "https://instagram.com",
        "mapsUrl": "https://maps.app.goo.gl/NU3pgPJnW6ydWmnv7",
        "description":
            "Join Company B as a Product Designer in Jakarta! We're looking for creative minds to craft intuitive digital experiences.",
      },
      {
        "company": "Company C",
        "logo": "assets/images/companyc.jpg",
        "headerImage": "assets/images/kantor_c.jpg",
        "position": "Content Creator",
        "location": "Semarang",
        "days": "10/05/2025",
        "tags": ["Media", "Writing"],
        "applyUrl": "https://facebook.com",
        "mapsUrl": "https://maps.app.goo.gl/1RrFGKTU3CAXAbpj6",
        "description":
            "Join Company C as a Part-Time Content Creator in Semarang! Create engaging content, work with a great team, and grow your skills with flexible hours.",
      },
    ];

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
              // ===== CONTENT (SCROLL) =====
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  // ===== SORT DROPDOWN (RIGHT TOP) =====
                  Padding(
                    padding: const EdgeInsets.only(right: 16, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MouseRegion(
                          onEnter: (_) => setState(() => _hoveredSort = 'dropdown'),
                          onExit: (_) => setState(() => _hoveredSort = null),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
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

                  // ===== LIST JOBS =====
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: jobs.map((job) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.all(14),
                          width: screenWidth * 0.92,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF1B4D4A),
                                const Color(0xFF2A6B66),
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

                              // POSITION
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
                                      Text(job['location'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 11)),
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
                                              color: Colors.white,
                                              fontSize: 11)),
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
                                  job['description'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      height: 1.3),
                                ),
                              ),
                              const SizedBox(height: 8),

                              // BUTTON DETAIL
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(221, 2, 92, 77),
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
                                          company: job['company'],
                                          position: job['position'],
                                          location: job['location'],
                                          tags: List<String>.from(job['tags']),
                                          image: job['logo'],
                                          headerImage: job['headerImage'],
                                          applyUrl: job['applyUrl'],
                                          mapsUrl: job['mapsUrl'],
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
                              )
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
