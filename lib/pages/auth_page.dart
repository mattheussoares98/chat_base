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

  void _handleSubmit(AuthFormData formData) {
    setState(() {
      isLoading = true;
    });

    try {
      if (formData.isLogin) {
        AuthService().login(
          formData.email,
          formData.password,
        );
        if (AuthService().error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuário/senha inválido'),
            ),
          );
        }
      } else {
        AuthService().signUp(
          formData.name,
          formData.password,
          formData.image,
          formData.email,
        );
      }
    } catch (error) {
      print('erro pra cadastrar $error');
      error;
    }

    AuthService().error = null;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          AuthForm(onSubmit: _handleSubmit),
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
