class NotificationItem {
  final int? id;
  final String message;
  bool isRead; // ✅ Make this mutable

  NotificationItem({
    this.id,
    required this.message,
    required this.isRead,
  });

  factory NotificationItem.fromMap(Map<String, dynamic> map) {
    return NotificationItem(
      id: map['id'] as int?,
      message: map['message'] as String,
      isRead: map['is_read'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'is_read': isRead ? 1 : 0,
    };
  }
}
