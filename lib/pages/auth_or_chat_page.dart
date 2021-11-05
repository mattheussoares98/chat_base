import 'package:chat_base/core/models/chat_user.dart';
import 'package:chat_base/core/services/auth/auth_mock_service.dart';
import 'package:chat_base/core/services/auth/auth_service.dart';
import 'package:chat_base/pages/auth_page.dart';
import 'package:chat_base/pages/chat_page.dart';
import 'package:chat_base/pages/loading_page.dart';
import 'package:flutter/material.dart';

class AuthOrChatPage extends StatelessWidget {
  const AuthOrChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthService().userChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return snapshot.hasData ? const ChatPage() : const AuthPage();
          }
        },
      ),
    );
  }
}
