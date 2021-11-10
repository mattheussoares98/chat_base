import 'dart:math';

import 'package:chat_base/components/messages.dart';
import 'package:chat_base/components/new_message.dart';
import 'package:chat_base/core/services/auth/auth_service.dart';
import 'package:chat_base/core/services/notification/chat_notification_service.dart';
import 'package:chat_base/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Chat')),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Text('Sair'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const NotificationPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.notifications),
              ),
              Positioned(
                right: 5,
                top: 4,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    '${Provider.of<ChatNotificationService>(context).itemCount}',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
