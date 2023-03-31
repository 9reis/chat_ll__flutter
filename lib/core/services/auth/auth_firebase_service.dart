import 'dart:async';
import 'dart:io';

import 'package:chat_ll__flutter/core/models/chat_user.dart';
import 'package:chat_ll__flutter/core/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

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
    final signup = await Firebase.initializeApp(
      name: 'userSignup',
      options: Firebase.app().options,
    );
    final auth = FirebaseAuth.instanceFor(app: signup);

    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user != null) {
      // 1. Upload da foto do user / Img recebida , nome da img
      final imageName = '${credential.user!.uid}.jpg';
      final imageURL = await _uploadUserImage(image, imageName);

      // 2. Atualizar os atributos do user
      await credential.user?.updateDisplayName(name);
      //A partir do user logado, vai ter acesso a imgURL
      await credential.user?.updatePhotoURL(imageURL);

      // 2.5 Fazer o login do usuario
      await login(email, password);

      // 3. Salvar o user no banco de dados (opcional)
      _currentUser = _toChatUser(credential.user!, name, imageURL);
      await _saveChatUser(_currentUser!);
    }
    await signup.delete();
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

  // Retorna a URL da imagem
  Future<String?> _uploadUserImage(File? image, String imageName) async {
    // Caso tenha passado uma imagem nula
    if (image == null) return null;
    //Pega o Storage
    final storage = FirebaseStorage.instance;
    //Pega o bucket padrão / Cria uma pasta / Nome da img que quer persistir
    // Referencia da imagem / Caminho
    final imageRef = storage.ref().child('user_image').child(imageName);
    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;

    // Pega a referencia do banco
    final docRef = store.collection('user').doc(user.id);

    // Salva um obj com as informaçoes que deseja persistir no banco
    return docRef.set({
      'name': user.name,
      'email': user.email,
      'imageURL': user.imageUrl,
    });
  }

  //TO ChartUser
  static ChatUser _toChatUser(User user, [String? name, String? imageURL]) {
    return ChatUser(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageUrl: imageURL ?? user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
