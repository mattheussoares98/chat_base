import 'dart:io';

import 'package:chat_base/components/user_image_picker.dart';
import 'package:chat_base/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function(AuthFormData formData) onSubmit;
  const AuthForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

AuthFormData _formData = AuthFormData();

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  _submit() {
    bool isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    widget.onSubmit(_formData);

    //aparece uma mensagem dizendo que precisa selecionar uma imagem quando não tem alguma selecionada
    // if (_formData.image == null && _formData.isSignUp) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       backgroundColor: Colors.red,
    //       content: Text(
    //         'Selecione uma imagem!',
    //         style: TextStyle(),
    //       ),
    //     ),
    //   );
    // }
  }

  void _handleImagePick(File? image) {
    setState(() {
      _formData.image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: const EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (_formData.isSignUp)
                        UserImagePicker(
                          imagePick: _handleImagePick,
                        ),
                      if (_formData.isSignUp)
                        TextFormField(
                          initialValue: _formData.name,
                          onChanged: (value) => _formData.name = value,
                          key: const ValueKey('name'),
                          decoration: const InputDecoration(
                            labelText: 'Nome',
                          ),
                          validator: (_name) {
                            _name = _formData.name;
                            if (_formData.name.trim().length < 3) {
                              return 'O nome deve conter pelo menos 3 caracteres';
                            }
                            return null;
                          },
                        ),
                      TextFormField(
                        initialValue: _formData.email,
                        onChanged: (email) => _formData.email = email,
                        key: const ValueKey('email'),
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                        ),
                        validator: (_) {
                          if (!_formData.email.trim().contains('@') ||
                              !_formData.email.trim().contains('.')) {
                            return 'E-mail inválido';
                          }
                          if (_formData.email.contains(' ')) {
                            return 'O e-mail não pode conter espaços';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        initialValue: _formData.password,
                        onChanged: (password) => _formData.password = password,
                        key: const ValueKey('password'),
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                        ),
                        validator: (_) {
                          if (_formData.password.length < 6) {
                            return 'A senha deve conter pelo menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _submit,
                        child: Text(
                          _formData.isLogin ? 'Entrar' : 'Cadastrar',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _formData.toggleAuthMode();
                          });
                        },
                        child: Text(_formData.isLogin
                            ? 'Alternar p/ cadastro'
                            : 'Alternar p/ login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
