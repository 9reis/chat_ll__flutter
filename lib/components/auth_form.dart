import 'package:chat_ll__flutter/models/auth_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.onSubmit}) : super(key: key);

  final void Function(AuthFormData) onSubmit;

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
                  validator: (_name) {
                    final name = _name ?? "";
                    if (name.trim().length < 5) {
                      return 'O nome deve ter no minimo 5 caracters';
                    }
                    return null;
                  },
                ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                key: const ValueKey('email'),
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (_email) {
                  final email = _email ?? '';
                  if (!email.contains('@')) {
                    return 'E-mail informado é invalido';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                key: const ValueKey('password'),
                //Esconde a senha
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.length < 6) {
                    return 'A senha deve ter no minimo 6 caracters';
                  }
                  return null;
                },
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
    //Valida o formulario
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    widget.onSubmit(_formData);
  }
}
