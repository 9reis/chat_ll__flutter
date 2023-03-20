// ignore_for_file: implementation_imports

import 'package:chat_ll__flutter/core/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {Key? key, required this.message, required this.belongsToCurrentUser})
      : super(key: key);
  //Messagem
  final ChatMessage message;
  //Se pertence ao user corrente
  final bool belongsToCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: belongsToCurrentUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          width: 180,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: belongsToCurrentUser
                  ? Colors.grey.shade300
                  : Theme.of(context).accentColor),
          child: Column(
            children: [
              Text(
                message.userName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: belongsToCurrentUser ? Colors.black : Colors.white),
              ),
              Text(
                message.text,
                style: TextStyle(
                    color: belongsToCurrentUser ? Colors.black : Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
