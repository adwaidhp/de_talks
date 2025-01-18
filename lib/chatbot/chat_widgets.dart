import 'package:de_talks/chatbot/animated_chat_bubble.dart';
import 'package:de_talks/chatbot/theme.dart';
import 'package:de_talks/colors.dart';
import 'package:flutter/material.dart';

class ChatMessageList extends StatelessWidget {
  final List<ChatMessage> messages;
  final ScrollController scrollController;

  ChatMessageList({
    required this.messages,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return ChatBubble(
          message: message,
          showAvatar: _shouldShowAvatar(index),
        );
      },
    );
  }

  bool _shouldShowAvatar(int index) {
    if (index == 0) return true;
    final currentMessage = messages[index];
    final previousMessage = messages[index - 1];
    return currentMessage.isUser != previousMessage.isUser;
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool showAvatar;

  ChatBubble({
    required this.message,
    this.showAvatar = true,
  });

  // In the ChatBubble widget
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser && showAvatar) _buildAvatar(),
          SizedBox(width: 8),
          Flexible(
            child: AnimatedChatBubble(
              isUser: message.isUser,
              child: Container(
                decoration: message.isUser
                    ? ChatTheme.userBubbleDecoration
                    : ChatTheme.botBubbleDecoration,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  message.text,
                  style: message.isUser
                      ? ChatTheme.userMessageStyle
                      : ChatTheme.botMessageStyle,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          if (message.isUser && showAvatar) _buildAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 16,
      backgroundColor:
          message.isUser ? ChatTheme.primaryColor : AppColors.darkerGrey,
      child: Icon(
        message.isUser ? Icons.person : Icons.android,
        size: 18,
        color: Colors.white,
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isTyping;

  ChatInputField({
    required this.controller,
    required this.onSend,
    this.isTyping = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -2),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: ChatTheme.inputDecoration,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              enabled: !isTyping,
            
            ),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            onPressed: isTyping ? null : onSend,
            child: Icon(
              isTyping ? Icons.hourglass_empty : Icons.send,
              color: Colors.white,
            ),
            backgroundColor: isTyping ? Colors.grey : ChatTheme.primaryColor,
            mini: true,
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : this.timestamp = timestamp ?? DateTime.now();
}
