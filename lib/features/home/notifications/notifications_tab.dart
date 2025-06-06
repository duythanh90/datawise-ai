import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifications_provider.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<NotificationsProvider>().loadNotificationsFromDb(),
      builder: (context, snapshot) {
        final provider = Provider.of<NotificationsProvider>(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF121212),
            title: const Text('Notifications'),
            actions: [
              if (provider.hasUnread)
                TextButton(
                  onPressed: () => provider.markAllAsRead(),
                  child: const Text(
                    'Mark all as read',
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ],
          ),
          backgroundColor: const Color(0xFF121212),
          body: provider.notifications.isEmpty
              ? const Center(
                  child: Text(
                    'No notifications',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.notifications.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: Colors.grey),
                  itemBuilder: (context, index) {
                    final notification = provider.notifications[index];
                    return ListTile(
                      title: Text(
                        notification.message,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: notification.isRead
                              ? FontWeight.normal
                              : FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
