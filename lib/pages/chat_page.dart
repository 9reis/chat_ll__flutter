import 'package:chat_ll__flutter/components/messages.dart';
import 'package:chat_ll__flutter/components/new_message.dart';
import 'package:chat_ll__flutter/core/services/auth/auth_service.dart';
import 'package:chat_ll__flutter/core/services/notification/chat_notification_service.dart';
import 'package:chat_ll__flutter/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
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
              ),
            ),
          ),
          Stack(children: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return NotificationPage();
                    },
                  ),
                );
              },
            ),
            Positioned(
              top: 5, //12
              right: 5,
              child: CircleAvatar(
                maxRadius: 9,
                backgroundColor: Colors.red,
                child: Text(
                  '${Provider.of<ChatNotificationService>(context).itemsCount}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ]),
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
