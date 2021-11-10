import 'dart:math';

import 'package:chat_base/components/message_bubble.dart';
import 'package:chat_base/core/models/chat_message.dart';
import 'package:chat_base/core/services/auth/auth_service.dart';
import 'package:chat_base/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = AuthService().currentUser;
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Não há mensagens. Vamos conversar?'),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (context, indice) {
              return MessageBubble(
                key: ValueKey(msgs[indice].id),
                belongsToCurrentUser: isCurrentUser!.id == msgs[indice].userId,
                message: ChatMessage(
                  id: Random().nextDouble().toString(),
                  text: msgs[indice].text,
                  createdAt: DateTime.now(),
                  userId: '1',
                  userName: msgs[indice].userName,
                  userImageUrl: msgs[indice].userImageUrl,
                ),
              );
            },
          );
        }
      },
    );
  }
}
