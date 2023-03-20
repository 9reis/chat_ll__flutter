// Met necessarios para autenticação
import 'dart:io';

import 'package:chat_ll__flutter/core/models/chat_user.dart';
import 'package:chat_ll__flutter/core/services/auth/auth_mock_service.dart';

abstract class AuthService {
  // Pega o usuario logado
  ChatUser? get currentUser;

  //Sequencia de dados
  // Lança novos dados sempre que mudar o estado do user
  // Faz com que a interface detecte que o user foi logado
  Stream<ChatUser?> get userChanges;

  // Onde será alterado o estado do usuario logado
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  );
  Future<void> login(String email, String password);
  Future<void> logout();

  //Permite salvar uma instancia e retornar ele
  // Podendo utilizar todos os met que essa instancia possui
  factory AuthService() {
    return AuthMockService();
  }
}
