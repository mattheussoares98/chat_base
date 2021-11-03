import 'dart:async';
import 'dart:math';

import 'package:chat_base/core/models/chat_user.dart';
import 'dart:io';

import 'package:chat_base/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static ChatUser? _currentUser;
  static Map<String, ChatUser> _users = {};
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi(
    (controller) {
      _controller = controller;
      _updateUser(null);
    },
  );

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> login(
    String email,
    String password,
  ) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signUp(
    String name,
    String password,
    File? image,
    String email,
  ) async {
    final newUser = ChatUser(
      email: email,
      id: Random().nextDouble().toString(),
      imageUrl: image!.path,
      name: name,
    );

    _users.putIfAbsent(email, () => newUser);

    _updateUser(newUser);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
