import 'dart:io';

import 'package:chat_ll__flutter/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {Key? key, required this.message, required this.belongsToCurrentUser})
      : super(key: key);
  //Messagem
  final ChatMessage message;
  //Se pertence ao user corrente
  final bool belongsToCurrentUser;

  static const _defaultImage = 'assets/images/avatar.png';

  Widget _showUserImage(String imageURL) {
    ImageProvider? provider;
    final uri = Uri.parse(imageURL);

    // Se a img vier do assets
    if (uri.path.contains(_defaultImage)) {
      provider = AssetImage(_defaultImage);
    }
    //protocolo
    // Se a img vier da internet
    else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      // Se a img vier do celular
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: belongsToCurrentUser
                        ? Radius.circular(12)
                        : Radius.circular(0),
                    bottomRight: belongsToCurrentUser
                        ? Radius.circular(0)
                        : Radius.circular(12),
                  ),
                  color: belongsToCurrentUser
                      ? Colors.grey.shade300
                      : Theme.of(context).accentColor),
              child: Column(
                children: [
                  Text(
                    message.userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            belongsToCurrentUser ? Colors.black : Colors.white),
                  ),
                  Text(
                    message.text,
                    style: TextStyle(
                        color:
                            belongsToCurrentUser ? Colors.black : Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? null : 165,
          right: belongsToCurrentUser ? 165 : null,
          child: _showUserImage(message.userImageUrl),
        )
      ],
    );
  }
}
