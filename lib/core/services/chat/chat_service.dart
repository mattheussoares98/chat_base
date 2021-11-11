import 'package:chat_base/core/models/chat_message.dart';
import 'package:chat_base/core/models/chat_user.dart';
import 'chat_firebase_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage?> save(ChatUser user, String text);

  factory ChatService() {
    return ChatFirebaseService();
  }
}
