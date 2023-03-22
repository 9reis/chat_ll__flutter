//Decide entra a tela de autenticação e a tela da app

import 'package:chat_ll__flutter/core/models/chat_user.dart';
import 'package:chat_ll__flutter/core/services/auth/auth_service.dart';
import 'package:chat_ll__flutter/pages/auth_page.dart';
import 'package:chat_ll__flutter/pages/chat_page.dart';
import 'package:chat_ll__flutter/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});
  //Para poder interagir com o Firebase
  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    //Se o usuário está logado
    return FutureBuilder(
      future: init(context),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else {
          return StreamBuilder<ChatUser?>(
            stream: AuthService().userChanges,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingPage();
              } else {
                return snapshot.hasData ? ChatePage() : AuthPage();
              }
            },
          );
        }
      },
    );
  }
}
