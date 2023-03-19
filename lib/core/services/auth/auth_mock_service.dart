import 'dart:io';

import 'package:chat_ll__flutter/core/models/chat_user.dart';
import 'package:chat_ll__flutter/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  // Independente da instancia de AuthMockService
  // Vai receber os mesmos users
  static Map<String, ChatUser> _users = {};

  //Static pois ñ faz sentido ter multiplos usuários
  // dentro da mesma aplicação
  static ChatUser? _currentUser;

  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get userChanges {}

  Future<void> signup(
      String nome, String email, String password, File image) async {}

  Future<void> login(String email, String password) async {}
  Future<void> logout() async {}
}
