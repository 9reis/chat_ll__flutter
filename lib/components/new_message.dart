import 'package:chat_ll__flutter/core/services/auth/auth_service.dart';
import 'package:chat_ll__flutter/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = "";
  //Controller para limpar o textField
  final _messageController = TextEditingController();

  //Adiciona uma nova mensagem
  Future<void> _sendMessage() async {
    //Pega o user logado
    final user = AuthService().currentUser;

    if (user != null) {
      final msg = await ChatService().save(_message, user);
      print(msg?.id);
      //Se tiver mandado a msg, ai sim limpa o input
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: "Enviar mensagem..."),
              //Antera a msg quando começar a digitar
              onChanged: (msg) => setState(() => _message = msg),
              // Manda a msg através do enter
              onSubmitted: (_) {
                if (_message.isNotEmpty) {
                  _sendMessage();
                }
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              //Se a msg estiver diferente de vazio, chama o met
              onPressed: _message.trim().isEmpty ? null : _sendMessage)
        ],
      ),
    );
  }
}
