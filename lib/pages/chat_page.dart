import 'package:chat_ll__flutter/components/messages.dart';
import 'package:chat_ll__flutter/components/new_message.dart';
import 'package:chat_ll__flutter/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatePage extends StatelessWidget {
  const ChatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: Text('9reis chat'),
        centerTitle: true,
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black87,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Sair')
                    ],
                  ),
                ),
              )
            ],
            onChanged: (value) {
              if (value == 'logout') {
                AuthService().logout();
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
