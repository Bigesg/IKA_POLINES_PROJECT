import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'event_detail.dart';
import 'beasiswadetail.dart';
import 'donasidetail.dart';
import 'utils/api_helper.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int selectedIndex = 0;
  final List<String> tabs = ["Berita", "Beasiswa", "Donasi"];
  List events = [];
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      final url = ApiHelper.apiUrl('events');
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final parsed = json.decode(res.body);
        final list = parsed is List ? parsed : (parsed['data'] ?? []);

        setState(() {
          events = list;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (e) {
      debugPrint("ERROR FETCH EVENT: $e");
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  /// ✅ FILTER YANG BENAR
  List get filteredEvents {
    final activeCategory = tabs[selectedIndex].toLowerCase();

    return events.where((item) {
      final category =
          (item['kategori_event'] ?? 'Berita').toString().toLowerCase();
      return category == activeCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final displayList = filteredEvents;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset('assets/images/Logo.png', height: 90),
                  const SizedBox(height: 10),
                  const Text(
                    "IKATAN ALUMNI\nPOLINES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ),

            // TABS
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(tabs.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedIndex = index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? const Color(0xFF004E46)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),

            // CONTENT
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : displayList.isEmpty
                      ? Center(
                          child: Text(
                              "Belum ada data ${tabs[selectedIndex]}"),
                        )
                      : RefreshIndicator(
                          onRefresh: fetchEvents,
                          child: ListView.builder(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: displayList.length,
                            itemBuilder: (context, index) {
                              final item = displayList[index];

                              final title =
                                  item['judul_event'] ?? "Tanpa Judul";
                              final content =
                                  item['deskripsi_event'] ?? "-";
                              final date =
                                  item['tanggal_event'] ?? "-";
                              final imgUrl = ApiHelper.resolveImageUrl(
                                      item['gambar_event']) ??
                                  "";

                                  debugPrint("IMAGE URL: $imgUrl");
                              final location = "Polines";

                              return _eventCard(
                                title: title,
                                subtitle: date,
                                imgUrl: imgUrl,
                                onTap: () {
                                  if (selectedIndex == 0) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EventDetailPage(
                                          title: title,
                                          content: content,
                                          image: imgUrl,
                                          date: date,
                                          location: location,
                                          tujuan: item['tujuan_kegiatan'] ?? '',
                                        ),
                                      ),
                                    );
                                  } else if (selectedIndex == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BeasiswaDetailPage(
                                          title: title,
                                          content: content,
                                          image: imgUrl,
                                          date: date,
                                          location: location,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DonasiDetailPage(
                                          title: title,
                                          content: content,
                                          image: imgUrl,
                                          date: date,
                                          location: location,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  /// CARD
  Widget _eventCard({
    required String title,
    required String imgUrl,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imgUrl,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    "assets/images/Logo.png",
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(subtitle,
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
