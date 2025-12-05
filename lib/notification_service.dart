import 'dart:math';
import 'package:flutter/material.dart';
import 'models/notification_model.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  static List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  // Initialize with some sample notifications
  void initializeNotifications() {
    _notifications = [
      NotificationModel(
        id: 1,
        title: "Event Baru Tersedia",
        message: "Sarasehan Alumni akan diselenggarakan pada 8 Oktober 2025",
        type: "event",
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
        imageUrl: "assets/images/event_sarasehan.png",
      ),
      NotificationModel(
        id: 2,
        title: "Beasiswa Terbaru",
        message: "Beasiswa Alumni Polines 2025 telah dibuka, ayo daftar sekarang!",
        type: "beasiswa",
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: false,
      ),
      NotificationModel(
        id: 3,
        title: "Lowongan Kerja Baru",
        message: "PT. Teknologi Indonesia membuka 5 posisi baru di bidang IT",
        type: "loker",
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
      NotificationModel(
        id: 4,
        title: "Informasi Penting",
        message: "Pendaftaran alumni baru telah dibuka untuk tahun ini",
        type: "info",
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
      NotificationModel(
        id: 5,
        title: "Pengumuman",
        message: "Koperasi IKA Polines membuka program e-commerce untuk alumni",
        type: "info",
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        isRead: true,
      ),
    ];
  }

  // Add a new notification
  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
  }

  // Mark notification as read
  void markAsRead(int id) {
    final index = _notifications.indexWhere((notification) => notification.id == id);
    if (index != -1) {
      _notifications[index] = NotificationModel(
        id: _notifications[index].id,
        title: _notifications[index].title,
        message: _notifications[index].message,
        type: _notifications[index].type,
        timestamp: _notifications[index].timestamp,
        isRead: true,
        imageUrl: _notifications[index].imageUrl,
      );
    }
  }

  // Mark all notifications as read
  void markAllAsRead() {
    _notifications = _notifications.map((notification) => 
      NotificationModel(
        id: notification.id,
        title: notification.title,
        message: notification.message,
        type: notification.type,
        timestamp: notification.timestamp,
        isRead: true,
        imageUrl: notification.imageUrl,
      )
    ).toList();
  }

  // Get unread notifications count
  int getUnreadCount() {
    return _notifications.where((notification) => !notification.isRead).length;
  }

  // Get notifications filtered by type
  List<NotificationModel> getNotificationsByType(String type) {
    return _notifications.where((notification) => 
        notification.type.toLowerCase() == type.toLowerCase()).toList();
  }

  // Get only unread notifications
  List<NotificationModel> getUnreadNotifications() {
    return _notifications.where((notification) => !notification.isRead).toList();
  }

  // Clear a specific notification
  void clearNotification(int id) {
    _notifications.removeWhere((notification) => notification.id == id);
  }

  // Clear all notifications
  void clearAllNotifications() {
    _notifications.clear();
  }

  // Generate a random notification for testing
  void generateRandomNotification() {
    final types = ["info", "warning", "event", "beasiswa", "loker"];
    final random = Random();
    
    final newNotification = NotificationModel(
      id: _notifications.length + 1,
      title: "Notifikasi Acak ${_notifications.length + 1}",
      message: "Ini adalah notifikasi acak untuk pengujian. Isi pesan ini akan memberitahukan hal-hal penting terkait IKA Polines.",
      type: types[random.nextInt(types.length)],
      timestamp: DateTime.now(),
      isRead: false,
    );
    
    addNotification(newNotification);
  }
}
