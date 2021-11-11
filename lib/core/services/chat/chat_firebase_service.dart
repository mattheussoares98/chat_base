import 'dart:async';
import 'package:chat_base/core/models/chat_user.dart';
import 'package:chat_base/core/models/chat_message.dart';
import 'package:chat_base/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    return const Stream<List<ChatMessage>>.empty();
  }

  @override
  Future<ChatMessage?> save(ChatUser user, String text) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('chat').add({
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': user.id,
      'userName': user.name,
      'userImageUrl': user.imageUrl,
    });

    return null;
  }
}
