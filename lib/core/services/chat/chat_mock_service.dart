import 'dart:async';
import 'dart:math';

import 'package:chat_ll__flutter/core/models/chat_user.dart';
import 'package:chat_ll__flutter/core/models/chat_message.dart';
import 'package:chat_ll__flutter/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Bom dia',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Bia',
      userImageUrl: 'assets\images\avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Teremos reunião hoje?',
      createdAt: DateTime.now(),
      userId: '456',
      userName: 'Ana',
      userImageUrl: 'assets\images\avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'Teremos as 15:00',
      createdAt: DateTime.now(),
      userId: '789',
      userName: 'Bia',
      userImageUrl: 'assets\images\avatar.png',
    ),
  ];

  //Controller para criar uma nova mensagem
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    //Propaga a lista de msg
    controller.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  // Salva uma nova msg
  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    _msgs.add(newMessage);
    //Mostra a lista de msg quando houver uma nova msg
    _controller?.add(_msgs);

    return newMessage;
  }
}
