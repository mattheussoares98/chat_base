import 'dart:io';

import 'package:chat_base/core/models/chat_user.dart';

abstract class AuthService {
  Stream<ChatUser?> get userChanges;

  ChatUser? get currentUser;

  Future<void> login(
    String email,
    String password,
  );

  Future<void> signUp(
    String name,
    String password,
    File? image,
    String email,
  );

  Future<void> logout();
}
