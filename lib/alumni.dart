import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlumniListPage extends StatefulWidget {
  const AlumniListPage({super.key});

  @override
  State<AlumniListPage> createState() => _AlumniListPageState();
}

class _AlumniListPageState extends State<AlumniListPage> {
  List<dynamic> alumni = [];
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchAlumni();
  }

  Future<void> fetchAlumni() async {
    setState(() {
      isLoading = true;
      error = '';
    });
    try {
      final uri = Uri.parse('http://127.0.0.1:8000/api/alumni');
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        // Attempt parse JSON
        final body = res.body;
        try {
          final parsed = json.decode(body);
          if (parsed is List) {
            setState(() => alumni = parsed);
          } else if (parsed is Map && parsed['data'] is List) {
            setState(() => alumni = parsed['data']);
          } else {
            setState(() => error = 'Unexpected response format');
          }
        } catch (e) {
          setState(() => error = 'Failed parsing response');
        }
      } else {
        setState(() => error = 'Server returned ${res.statusCode}');
      }
    } catch (e) {
      setState(() => error = 'Network error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Alumni')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (error.isNotEmpty
              ? Center(child: Text(error))
              : (alumni.isEmpty
                  ? const Center(child: Text('Tidak ada data alumni'))
                  : ListView.builder(
                      itemCount: alumni.length,
                      itemBuilder: (context, index) {
                        final a = alumni[index];
                        return ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.person)),
                          title: Text(a['nama_lengkap'] ?? a['nama_alumni'] ?? '-'),
                          subtitle: Text(a['jurusan'] ?? a['jurusan_alumni'] ?? '-'),
                          onTap: () {
                            // simple detail dialog
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(a['nama_lengkap'] ?? a['nama_alumni'] ?? '-'),
                                content: Text('No WA: ' + (a['no_wa'] ?? '-')),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup')),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ))),
    );
  }
}
