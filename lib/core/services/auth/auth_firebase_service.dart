import 'dart:async';
import 'package:chat_base/core/models/chat_user.dart';
import 'dart:io';
import 'package:chat_base/core/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;
  static String? errorMensage;

  static final _userStream = Stream<ChatUser?>.multi(
    (controller) async {
      //pega as alterações do usuário
      final authChanges = FirebaseAuth.instance.authStateChanges();

      await for (final user in authChanges) {
        _currentUser = user == null ? null : _toChatUser(user);
        controller.add(_currentUser);
      }
    },
  );

  static _toChatUser(User user, [String? name, String? imageUrl]) {
    return ChatUser(
      email: user.email!,
      id: user.uid,
      imageUrl: imageUrl ?? user.photoURL ?? 'lib/assets/avatar.png',
      name: name ?? user.displayName ?? user.email!.split('@')[0],
    );
  }

  @override
  String? get error {
    return errorMensage;
  }

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  set error(String? _error) {
    errorMensage = _error;
  }

  @override
  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      e;
      error = e.message;
      errorMensage = e.message;
    } finally {}
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

    //esse ref() retorna o bucket(caminho) padrão do firebase. Como criou o storage com o padrão, está usando esse ref() mesmo
    //a cada child é o nome de uma pasta. Então o nome da pasta vai ficar user_images/imagename
    //o primeiro child é o nome da pasta. O segundo child é o nome do arquivo
    final imageRef = storage.ref().child('user_images').child(imageName);

    //aqui ele faz o upload do arquivo
    await imageRef.putFile(image).whenComplete(() {});

    //aqui ele faz o download do arquivo
    return await imageRef.getDownloadURL();
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    return docRef.set({
      'name': user.name,
      'email': user.email,
      'imageUrl': user.imageUrl,
    });
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

    if (credencial.user == null) return;

    //1. upload da foto do usuário
    final imageName = '${credencial.user!.uid}.jpeg';
    final imageUrl = await _uploadUserImage(image, imageName);

    //2. atualizar os atributos do usuário
    await credencial.user?.updateDisplayName(name); //atualizar o nome
    await credencial.user?.updatePhotoURL(imageUrl);

    _currentUser = _toChatUser(credencial.user!, name, imageUrl);

    //3. adicionar o usuário no firebase firestore (opcional)
    await _saveChatUser(_currentUser!);
  }
}
