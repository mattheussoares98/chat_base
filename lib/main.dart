import 'package:chat_base/core/models/chat_notification.dart';
import 'package:chat_base/core/services/notification/push_notification_service.dart';
import 'package:chat_base/pages/auth_or_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ChatNotificationService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            headline6: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        home: const AuthOrChatPage(),
      ),
    );
  }
}
