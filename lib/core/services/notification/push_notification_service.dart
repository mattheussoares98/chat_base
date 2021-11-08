import 'package:chat_base/core/models/chat_notification.dart';
import 'package:flutter/cupertino.dart';

class ChatNotificationService with ChangeNotifier {
  final List<ChatNotification> _items = [];

  List<ChatNotification> get items {
    return [...items];
  }

  int get itemCount {
    return _items.length;
  }

  addNotification(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  removeNotification(int i) {
    _items.removeAt(i);
    notifyListeners();
  }
}
