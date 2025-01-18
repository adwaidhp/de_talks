import 'package:de_talks/api/groq_service.dart';
import 'package:de_talks/chatbot/chat_widgets.dart';
import 'package:de_talks/chatbot/theme.dart';
import 'package:de_talks/colors.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GroqService _groqService = GroqService();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  ChatMessage? _currentAnimatingMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 3,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Assistant',
              style: TextStyle(fontSize: 18),
            ),
            if (_isTyping)
              Text(
                'typing...',
                style: TextStyle(fontSize: 12),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _clearChat,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bg_chat.png'))),
        child: Column(
          children: [
            Expanded(
              child: ChatMessageList(
                messages: _messages,
                scrollController: _scrollController,
              ),
            ),
            ChatInputField(
              controller: _messageController,
              onSend: _handleSendMessage,
              isTyping: _isTyping,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  void _handleSendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: message, isUser: true));
      _messageController.clear();
      _isTyping = true;
    });

    _scrollToBottom();

    try {
      final response = await _groqService.getChatResponse(message);
      final chatMessage = ChatMessage(text: '', isUser: false);
      setState(() {
        _messages.add(chatMessage);
        _currentAnimatingMessage = chatMessage;
      });

      String displayText = '';
      for (int i = 0; i < response.length; i++) {
        if (_currentAnimatingMessage != chatMessage) break;
        await Future.delayed(Duration(milliseconds: 1));
        displayText += response[i];
        setState(() {
          chatMessage.text = displayText;
        });
      }

      setState(() {
        _isTyping = false;
        _currentAnimatingMessage = null;
      });
      _scrollToBottom();
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _clearChat() {
    setState(() {
      _messages.clear();
    });
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 900),
        curve: Curves.easeOut,
      );
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
