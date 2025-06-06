import 'package:datawiseai/features/home/notifications/models/NotificationItem.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotificationsDbHelper {
  static Database? _db;

  static const String _tableName = 'notifications';

  static Future<Database> _getDb() async {
    if (_db != null) return _db!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notifications.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            message TEXT NOT NULL,
            is_read INTEGER NOT NULL
          )
        ''');
      },
    );

    return _db!;
  }

  static Future<int> insertNotification(NotificationItem item) async {
    final db = await _getDb();
    return await db.insert(_tableName, item.toMap());
  }

  static Future<List<NotificationItem>> getAllNotifications() async {
    final db = await _getDb();
    final maps = await db.query(
      _tableName,
      orderBy: 'id DESC',
    );
    return maps.map((map) => NotificationItem.fromMap(map)).toList();
  }

  static Future<void> markAllAsRead() async {
    final db = await _getDb();
    await db.update(
      _tableName,
      {'is_read': 1},
    );
  }

  static Future<void> deleteAll() async {
    final db = await _getDb();
    await db.delete(_tableName);
  }
}
