import 'package:flutter/material.dart';
import 'package:de_talks/colors.dart';

class AppTextStyles {
  static const TextStyle regular = TextStyle(
    fontFamily: 'Manjari',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static const TextStyle bold = TextStyle(
    fontFamily: 'Manjari',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static const TextStyle thin = TextStyle(
    fontFamily: 'Manjari',
    fontSize: 16,
    fontWeight: FontWeight.w100,
    color: AppColors.black,
  );

  // Heading styles
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Manjari',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  // Chat styles
  static const TextStyle chatMessage = TextStyle(
    fontFamily: 'Manjari',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
}
