import 'dart:io';

import 'package:chat_ll__flutter/core/models/chat_user.dart';
import 'package:chat_ll__flutter/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  ChatUser? get currentUser {
    return null;
  }

  Stream<ChatUser?> get userChanges {}

  Future<void> signup(
      String nome, String email, String password, File image) async {}

  Future<void> login(String email, String password) async {}
  Future<void> logout() async {}
}
