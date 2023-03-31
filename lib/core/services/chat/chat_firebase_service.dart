import 'dart:async';

import 'package:chat_ll__flutter/core/models/chat_user.dart';
import 'package:chat_ll__flutter/core/models/chat_message.dart';
import 'package:chat_ll__flutter/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFIrebaseService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    return Stream<List<ChatMessage>>.empty();
  }

  // Salva uma nova msg
  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    // ChatMessage TO Map<String,dynamic>
    // Que é o tipo aceito pelo Firebase
    final docRef = await store.collection('chat').add({
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': user.id,
      'userName': user.name,
      'userImageUrl': user.imageUrl
    });
    final doc = await docRef.get();
    final data = doc.data()!;
  }
  
  //.withConverter(fromFirestore: fromFirestore, toFirestore: toFirestore)

  // fromFirestore - Recebe os dados do Firestore
  // Map<String,dynamic> TO ChatMessage
  ChatMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions options,
  ) {
    return ChatMessage(
      id: doc.id,
      text: doc['text'],
      createdAt: DateTime.parse(doc['createdAt']),
      userId: doc['userId'],
      userName: doc['userName'],
      userImageUrl: doc['userImageUrl'],
    );
  }
}
