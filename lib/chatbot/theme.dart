import 'package:flutter/material.dart';
import 'package:de_talks/colors.dart';

class ChatTheme {
  // Colors from AppColors
  static const Color primaryColor = AppColors.darkBlueContrast;
  static const Color backgroundColor = AppColors.background;
  static const Color lightAccentColor = AppColors.lightBlueAccent;

  // User Message Theme
  static const userBubbleDecoration = BoxDecoration(
    color: AppColors.darkBlueContrast,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
      bottomLeft: Radius.circular(12),
    ),
    boxShadow: [
      BoxShadow(
        offset: Offset(0, 4),
        blurRadius: 4,
        color: AppColors.blackOverlay,
      ),
    ],
  );

  // Bot Message Theme
  static const botBubbleDecoration = BoxDecoration(
    color: AppColors.grey,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
      bottomRight: Radius.circular(12),
    ),
    boxShadow: [
      BoxShadow(
        offset: Offset(0, 4),
        blurRadius: 4,
        color: AppColors.blackOverlay,
      ),
    ],
  );

  // Text Styles
  static const userMessageStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.8,
  );

  static const botMessageStyle = TextStyle(
    color: AppColors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.8,
  );

  // Input Decoration
  static final inputDecoration = InputDecoration(
    hintText: 'Type a message...',
    hintStyle: TextStyle(
      color: AppColors.darkerGrey,
      fontSize: 16,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: AppColors.grey,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.darkBlueContrast,
        width: 2,
      ),
    ),
  );

  // Chat Container Decoration
  static final chatContainerDecoration = BoxDecoration(
    color: AppColors.background,
    image: DecorationImage(
      image: AssetImage('assets/images/HomePageBg.png'),
      fit: BoxFit.cover,
    ),
  );

  // Message Container Shadow
  static const messageShadow = BoxShadow(
    offset: Offset(0, 4),
    blurRadius: 4,
    color: AppColors.blackOverlay,
  );

  // Header Text Style
  static const headerStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  // Typing Indicator Style
  static const typingIndicatorStyle = TextStyle(
    fontSize: 12,
    color: AppColors.darkerGrey,
  );
}
