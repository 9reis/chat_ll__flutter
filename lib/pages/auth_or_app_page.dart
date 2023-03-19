//Decide entra a tela de autenticação e a tela da app

import 'package:chat_ll__flutter/core/models/chat_user.dart';
import 'package:chat_ll__flutter/core/services/auth/auth_mock_service.dart';
import 'package:chat_ll__flutter/pages/auth_page.dart';
import 'package:chat_ll__flutter/pages/chat_page.dart';
import 'package:chat_ll__flutter/pages/loading_page.dart';
import 'package:flutter/material.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Se o usuário está logado
      body: StreamBuilder<ChatUser?>(
        stream: AuthMockService().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          } else {
            return snapshot.hasData ? ChatePage() : AuthPage();
          }
        },
      ),
    );
  }
}
