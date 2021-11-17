import 'package:chat_base/components/auth_form.dart';
import 'package:chat_base/core/models/auth_form_data.dart';
import 'package:chat_base/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = false;

  _showErrorMessage(String? msg) {
    if (msg == null || msg.isEmpty) {
      return;
    } else if (msg ==
        'The password is invalid or the user does not have a password.') {
      msg = 'Senha inválida';
    } else if (msg ==
        'There is no user record corresponding to this identifier. The user may have been deleted.') {
      msg = 'Usuário não encontrado';
    } else if (msg == 'The email address is badly formatted.') {
      msg = 'E-mail inválido';
    }

    if (AuthService().error != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            msg,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      setState(() {
        isLoading = true;
      });
      if (formData.isLogin) {
        await AuthService().login(
          formData.email,
          formData.password,
        );
        _showErrorMessage(AuthService().error);
      } else {
        await AuthService().signUp(
          formData.name,
          formData.password,
          formData.image,
          formData.email,
        );
      }
    } catch (error) {
      error;
    } finally {
      AuthService().error = null;

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          AuthForm(
            onSubmit: _handleSubmit,
          ),
          if (isLoading)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black12,
              child: null,
            ),
          if (isLoading)
            const Center(
              // ignore: avoid_unnecessary_containers
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
