import 'package:chat_base/core/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Minhas notificações'),
        ),
      ),
      body: ListView.builder(
          itemCount: service.itemCount,
          itemBuilder: (ctx, index) {
            return ListTile(
              title: Text(items[index].title),
              subtitle: Text(items[index].body),
              onTap: () => service.removeNotification(index),
            );
          }),
    );
  }
}
