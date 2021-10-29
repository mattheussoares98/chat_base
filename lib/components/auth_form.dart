import 'package:chat_base/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

AuthFormData _formData = AuthFormData();

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    _submit() {
      _formKey.currentState!.validate();
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: const EdgeInsets.all(8),
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (_formData.isSignUp)
                        TextFormField(
                          initialValue: _formData.name,
                          onChanged: (value) => _formData.name = value,
                          key: const ValueKey('name'),
                          decoration: const InputDecoration(
                            labelText: 'Nome',
                          ),
                        ),
                      TextFormField(
                        initialValue: _formData.email,
                        onChanged: (email) => _formData.email = email,
                        key: const ValueKey('email'),
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                        ),
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
