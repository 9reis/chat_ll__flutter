import 'package:chat_ll__flutter/models/auth_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formData = AuthFormData();
  //Para acessar os dados do form a partir de um global key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup)
                TextFormField(
                  // Valor inicial para o campo
                  initialValue: _formData.name,
                  //Garda o valor digitado/mudança de valor
                  onChanged: (name) => _formData.name = name,
                  key: const ValueKey('name'),
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
              TextFormField(
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                key: const ValueKey('email'),
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              TextFormField(
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                key: const ValueKey('password'),
                //Esconde a senha
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
                onPressed: _submit,
              ),
              TextButton(
                child: Text(_formData.isLogin
                    ? 'Cria uma nova conta ?'
                    : 'Já possui conta ?'),
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    _formKey.currentState?.validate();
  }
}
