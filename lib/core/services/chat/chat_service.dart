import 'package:chat_base/core/models/chat_message.dart';
import 'package:chat_base/core/models/chat_user.dart';
import 'package:chat_base/core/services/chat/chat_mock_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage> save(ChatUser user, String text);

  factory ChatService() {
    return ChatMockService();
  }
}
