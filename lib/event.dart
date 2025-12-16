import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
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
    setState(() { isLoading = true; isError = false; });
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
        setState(() { isLoading = false; isError = true; });
      }
    } catch (e) {
      print("Error: $e");
      setState(() { isLoading = false; isError = true; });
    }
  }

  // --- [TAMBAHAN BARU] LOGIKA FILTERING ---
  // Fungsi ini otomatis menyaring data berdasarkan tab yang dipilih
  List get filteredEvents {
    // 1. Ambil nama kategori dari Tab yang aktif (Berita/Beasiswa/Donasi)
    String activeCategory = tabs[selectedIndex]; 

    // 2. Lakukan penyaringan (Filtering)
    return events.where((item) {
      // Pastikan nama kolom di database Anda benar. 
      // Contoh di sini saya anggap nama kolomnya 'kategori'.
      // Jika di database namanya 'category' atau 'jenis', ganti teks di bawah ini.
      String itemCategory = item['kategori'] ?? "Berita"; 
      
      // Bandingkan (case-insensitive biar aman)
      return itemCategory.toLowerCase() == activeCategory.toLowerCase();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Ambil list yang sudah difilter
    final displayList = filteredEvents; 

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset('assets/images/Logo.png', height: 90),
                  const SizedBox(height: 10),
                  const Text(
                    "IKATAN ALUMNI\nPOLINES", 
                    textAlign: TextAlign.center, 
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1, color: Colors.black87)
                  ),
                ],
              ),
            ),

            // TABS
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3))]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(tabs.length, (index) {
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(color: selectedIndex == index ? const Color(0xFF004E46) : Colors.transparent, borderRadius: BorderRadius.circular(20)),
                      child: Text(tabs[index], style: TextStyle(color: selectedIndex == index ? Colors.white : Colors.black, fontWeight: FontWeight.w600)),
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
                  : displayList.isEmpty // Cek displayList, bukan events
                      ? Center(child: Text("Belum ada data ${tabs[selectedIndex]}"))
                      : RefreshIndicator(
                          onRefresh: fetchEvents,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: displayList.length, // Gunakan panjang list yang difilter
                            itemBuilder: (context, index) {
                              final item = displayList[index]; // Ambil dari list yang difilter

                              String title = item['judul_event'] ?? "Tanpa Judul";
                              String content = item['deskripsi_event'] ?? "-";
                              String date = item['tanggal_event'] ?? "-";
                              String imgUrl = ApiHelper.resolveImageUrl(item['gambar_event']) ?? "";
                              String location = "Polines"; 

                              return _eventCard(
                                title: title,
                                subtitle: date,
                                imgUrl: imgUrl,
                                onTap: () {
                                  // Navigasi sesuai Tab yang aktif
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
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => BeasiswaDetailPage(title: title, content: content, image: imgUrl, date: date, location: location)));
                                  } else {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => DonasiDetailPage(title: title, content: content, image: imgUrl, date: date, location: location)));
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
  
  // Widget _eventCard biarkan sama seperti sebelumnya...
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
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 5))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.grey[100],
                  child: imgUrl.isNotEmpty
                      ? Image.network(
                          imgUrl,
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/Logo.png",
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
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
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.grey),
                    ),
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