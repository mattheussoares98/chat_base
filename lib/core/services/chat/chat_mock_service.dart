import 'dart:async';
import 'dart:math';
import 'package:chat_base/core/models/chat_user.dart';
import 'package:chat_base/core/models/chat_message.dart';
import 'package:chat_base/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Bom dia',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Mattheus',
      userImageUrl: 'lib/assets/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Bom dia',
      createdAt: DateTime.now(),
      userId: '456',
      userName: 'Josicléia',
      userImageUrl: 'lib/assets/avatar.png',
    ),
    ChatMessage(
      id: '1',
      text: 'Tudo bem?',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Mattheus',
      userImageUrl: 'lib/assets/avatar.png',
    ),
  ];

  static MultiStreamController<List<ChatMessage>>? _controller;

  static final _msgsStream = Stream<List<ChatMessage>>.multi(
    (controller) {
      _controller = controller;
      controller.add(_msgs);
    },
  );

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(ChatUser user, String text) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: 'lib/assets/avatar.png',
    );
    _msgs.add(newMessage);
    _controller?.add(_msgs);

    return newMessage;
  }
}
