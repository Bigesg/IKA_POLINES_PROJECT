class EventModel {
  final int id;
  final String judulEvent;
  final String deskripsiEvent;
  final String tanggalEvent;
  final String gambarUrl;

  EventModel({
    required this.id,
    required this.judulEvent,
    required this.deskripsiEvent,
    required this.tanggalEvent,
    required this.gambarUrl,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      judulEvent: json['judul_event'],
      deskripsiEvent: json['deskripsi_event'],
      tanggalEvent: json['tanggal_event'],
      gambarUrl: json['gambar_url'] ?? "",
    );
  }
}
