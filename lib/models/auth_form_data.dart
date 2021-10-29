import 'dart:io';

enum AuthMode { login, signUp }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _mode = AuthMode.login;

  bool get isLogin {
    return _mode == AuthMode.login;
  }

  bool get isSignUp {
    return _mode == AuthMode.signUp;
  }

  toggleAuthMode() {
    _mode = isLogin ? AuthMode.signUp : AuthMode.login;
  }
}
