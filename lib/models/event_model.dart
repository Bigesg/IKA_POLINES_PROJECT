class EventModel {
  final int id;
  final String title;
  final String subtitle;
  final String image;

  EventModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
    );
  }
}
