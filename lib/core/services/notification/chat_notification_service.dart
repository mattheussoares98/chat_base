import 'package:chat_base/core/models/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class ChatNotificationService with ChangeNotifier {
  final List<ChatNotification> _items = [];

  List<ChatNotification> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void removeNotification(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  //pushNotification

  Future<void> init() async {
    await _configureForeground();
    await _configureBackground();
    await _configureTerminated();
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final permission = await messaging.requestPermission();
    return permission.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  //mostra a notificação quando o app está em segundo plano. Ele mostra igual uma notificação de qualquer outro app da forma padrão do android (quando arrasta pra baixo pra ver as notificações)
  Future<void> _configureBackground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

  Future<void> _configureTerminated() async {
    if (await _isAuthorized) {
      RemoteMessage? remoteMsg =
          await FirebaseMessaging.instance.getInitialMessage();

      _messageHandler(remoteMsg);
    }
  }

  void _messageHandler(RemoteMessage? msg) {
    if (msg == null || msg.notification == null) return;

    (msg) {
      add(ChatNotification(
        body: msg.notification!.body ?? 'Não informado',
        title: msg.notification!.title ?? 'Não informado',
      ));
    };
  }
}
