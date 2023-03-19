import 'package:chat_ll__flutter/components/auth_form.dart';
import 'package:chat_ll__flutter/models/auth_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(
                onSubmit: _handleSubmit,
              ),
            ),
          ),
          if (_isLoading)
            Container(
              child: Center(child: CircularProgressIndicator()),
              decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
            ),
        ],
      ),
    );
  }

  void _handleSubmit(AuthFormData formData) {
    setState(() => _isLoading = true);
    print('AuthPage...');
    print(formData.email);
    setState(() => _isLoading = false);
  }
}
