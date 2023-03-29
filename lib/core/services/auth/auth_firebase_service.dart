import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chat_ll__flutter/core/models/chat_user.dart';
import 'package:chat_ll__flutter/core/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;

  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    // Monitora as mudanças na parte de autenticação
    final authChanges = FirebaseAuth.instance.authStateChanges();
    //Quando houver uma modificação
    await for (final user in authChanges) {
      //Seta o user corrente
      _currentUser = user == null ? null : _toChatUser(user);
      //Add o user dentro da stream.
      controller.add(_currentUser);
    }
    //_controller = controller;
    //Gera um usuário null para poder ir para tela inicial
  });
  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final auth = FirebaseAuth.instance;

    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user == null) return;

    // Atualiza o nome do user
    credential.user?.updateDisplayName(name);
    //credential.user?.updatePhotoURL(photoURL);
  }

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    // Metodo responsável por fazer o logout da app
    FirebaseAuth.instance.signOut();
  }

  //TO ChartUser
  static ChatUser _toChatUser(User user) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageUrl: user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
