import 'package:flutter/material.dart';

class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String type; // 'info', 'warning', 'success', 'event', 'beasiswa', 'loker'
  final DateTime timestamp;
  final bool isRead;
  final String? imageUrl; // optional image for rich notifications

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'imageUrl': imageUrl,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      type: json['type'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'] ?? false,
      imageUrl: json['imageUrl'],
    );
  }

  // Method to get notification type color
  Color get typeColor {
    switch (type.toLowerCase()) {
      case 'info':
        return const Color(0xFF007AFF);
      case 'warning':
        return const Color(0xFFFF9500);
      case 'success':
        return const Color(0xFF34C759);
      case 'event':
        return const Color(0xFF5856D6);
      case 'beasiswa':
        return const Color(0xFF009688);
      case 'loker':
        return const Color(0xFFFF2D55);
      default:
        return const Color(0xFF8E8E93);
    }
  }

  // Method to get notification type icon
  IconData get typeIcon {
    switch (type.toLowerCase()) {
      case 'info':
        return Icons.info_outline;
      case 'warning':
        return Icons.warning_amber_outlined;
      case 'success':
        return Icons.check_circle_outline;
      case 'event':
        return Icons.event_outlined;
      case 'beasiswa':
        return Icons.school_outlined;
      case 'loker':
        return Icons.work_outline;
      default:
        return Icons.notifications_none;
    }
  }
}