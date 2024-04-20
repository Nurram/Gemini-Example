import 'package:flutter/material.dart';
import 'package:flutter_gemini_example/home/widgets/chat_bubble.dart';
import 'package:flutter_gemini_example/models/chat.dart';

class ChatItem extends StatelessWidget {
  final Chat chat;

  const ChatItem({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Visibility(
            visible: chat.role == 'model',
            child: ChatBubble(message: chat.output ?? ''),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Visibility(
            visible: chat.role != 'model',
            child: ChatBubble(message: chat.output ?? ''),
          ),
        ),
      ],
    );
  }
}
