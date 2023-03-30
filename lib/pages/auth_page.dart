import 'package:chat_ll__flutter/components/auth_form.dart';
import 'package:chat_ll__flutter/core/models/auth_form_data.dart';
import 'package:chat_ll__flutter/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

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

  //Recebe os dados do form
  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      if (!mounted) return;
      setState(() => _isLoading = true);

      if (formData.isLogin) {
        //Login
        await AuthService().login(
          formData.email,
          formData.password,
        );
      } else {
        //Signup
        AuthService().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } catch (error) {
      //Tratar erro
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }
}
