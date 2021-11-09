import 'dart:async';
import 'package:chat_base/core/models/chat_user.dart';
import 'dart:io';
import 'package:chat_base/core/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;

  static final _userStream = Stream<ChatUser?>.multi(
    (controller) async {
      //pega as alterações do usuário
      final authChanges = FirebaseAuth.instance.authStateChanges();

      await for (final user in authChanges) {
        _currentUser = user == null
            ? null
            : ChatUser(
                email: user.email!,
                id: user.uid,
                imageUrl: user.photoURL ?? 'lib/assets/avatar.png',
                name: user.displayName ?? user.email!.split('@')[0],
              );
        controller.add(_currentUser);
      }
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
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<String?> _uploadUserImage(
    File? image,
    String imageName,
  ) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
  }

  @override
  Future<void> signUp(
    String name,
    String password,
    File? image,
    String email,
  ) async {
    final auth = FirebaseAuth.instance;
    //fazer o cadastro do usuário no firebase
    UserCredential credencial = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    credencial.user?.updateDisplayName(name); //atualizar o nome
    // credencial.user?.updatePhotoURL(photoURL);
  }
}
