import 'package:chat_base/core/models/chat_user.dart';
import 'package:chat_base/core/services/auth/auth_service.dart';
import 'package:chat_base/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';
  final TextEditingController _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    ChatUser? _currentUser = AuthService().currentUser;

    if (_currentUser != null) {
      _messageController.clear();
      await ChatService().save(_currentUser, _message);
      // _message = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Digite a mensagem...',
            ),
            onChanged: (msg) => setState(() => _message = msg),
          ),
        ),
        IconButton(
          onPressed: _message.trim().isEmpty ? null : _sendMessage,
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
