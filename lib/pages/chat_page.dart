import 'package:chat_ll__flutter/core/services/auth/auth_mock_service.dart';
import 'package:flutter/material.dart';

class ChatePage extends StatelessWidget {
  const ChatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chat Page'),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                AuthMockService().logout();
              },
            )
          ],
        ),
      ),
    );
  }
}
