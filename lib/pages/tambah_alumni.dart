import 'package:flutter/material.dart';
import '../services/api_services.dart';

class TambahAlumniPage extends StatefulWidget {
  const TambahAlumniPage({super.key});

  @override
  State<TambahAlumniPage> createState() => _TambahAlumniPageState();
}

class _TambahAlumniPageState extends State<TambahAlumniPage> {
  final _formKey = GlobalKey<FormState>();
  final namaCtrl = TextEditingController();
  final nimCtrl = TextEditingController();
  final tahunCtrl = TextEditingController();
  final jurusanCtrl = TextEditingController();
  final prodiCtrl = TextEditingController();

  Future<void> _simpan() async {
    if (_formKey.currentState!.validate()) {
      final success = await ApiService.tambahAlumni({
        'nama_alumni': namaCtrl.text,
        'nim': nimCtrl.text,
        'tahun_lulus': tahunCtrl.text,
        'jurusan_alumni': jurusanCtrl.text,
        'prodi_alumni': prodiCtrl.text,
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil disimpan')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menyimpan data')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Alumni")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaCtrl,
                decoration: const InputDecoration(labelText: "Nama Alumni"),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: nimCtrl,
                decoration: const InputDecoration(labelText: "NIM"),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: tahunCtrl,
                decoration: const InputDecoration(labelText: "Tahun Lulus"),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: jurusanCtrl,
                decoration: const InputDecoration(labelText: "Jurusan"),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: prodiCtrl,
                decoration: const InputDecoration(labelText: "Prodi"),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _simpan,
                child: const Text("Simpan"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
