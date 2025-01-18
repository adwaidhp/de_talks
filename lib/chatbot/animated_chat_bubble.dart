import 'package:flutter/material.dart';

class AnimatedChatBubble extends StatefulWidget {
  final Widget child;
  final bool isUser;

  const AnimatedChatBubble({
    Key? key,
    required this.child,
    required this.isUser,
  }) : super(key: key);

  @override
  State<AnimatedChatBubble> createState() => _AnimatedChatBubbleState();
}

class _AnimatedChatBubbleState extends State<AnimatedChatBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: widget.isUser ? 50.0 : -50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuad,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_slideAnimation.value, 0),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
