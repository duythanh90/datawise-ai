import 'package:datawiseai/features/home/notifications/helpers/notifications_db_helper.dart';
import 'package:datawiseai/features/home/notifications/models/NotificationItem.dart';
import 'package:flutter/material.dart';

class NotificationsProvider with ChangeNotifier {
  final List<NotificationItem> _notifications = [];
  bool _hasUnread = false;

  List<NotificationItem> get notifications => _notifications;
  bool get hasUnread => _hasUnread;

  Future<void> loadNotificationsFromDb() async {
    final dbItems = await NotificationsDbHelper.getAllNotifications();

    // Seed test data if DB is empty
    if (dbItems.isEmpty) {
      await seedTestNotifications();
    }

    _notifications.clear();
    _notifications.addAll(await NotificationsDbHelper.getAllNotifications());
    _hasUnread = _notifications.any((n) => !n.isRead);
    notifyListeners();
  }

  Future<void> addNotification(String message) async {
    final newItem = NotificationItem(message: message, isRead: false);
    final id = await NotificationsDbHelper.insertNotification(newItem);
    _notifications.insert(
        0, NotificationItem(id: id, message: message, isRead: false));
    _hasUnread = true;
    notifyListeners();
  }

  Future<void> markAllAsRead() async {
    await NotificationsDbHelper.markAllAsRead();
    for (var n in _notifications) {
      n.isRead = true;
    }
    _hasUnread = false;
    notifyListeners();
  }

  Future<void> seedTestNotifications() async {
    final sampleMessages = [
      "🎉 Welcome to DataWise AI!",
      "📂 Your file 'report.pdf' has been processed.",
      "🧠 Smart answers are now enabled for your document.",
      "🔒 Privacy policy was updated on June 1st.",
      "📊 Insights from your latest data are available.",
    ];

    for (final msg in sampleMessages) {
      await addNotification(msg);
    }
  }
}
