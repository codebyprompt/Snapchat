import 'package:flutter/material.dart';

class AppColors {
  // Primary Snapchat colors
  static const Color snapYellow = Color(0xFFFFFC00);
  static const Color snapBlack = Color(0xFF000000);
  static const Color snapWhite = Color(0xFFFFFFFF);
  static const Color snapGrey = Color(0xFF8E8E93);
  static const Color snapLightGrey = Color(0xFFF2F2F7);
  static const Color snapDarkGrey = Color(0xFF1C1C1E);

  // Chat colors
  static const Color chatBlue = Color(0xFF0084FF);
  static const Color chatRed = Color(0xFFFF3B30);
  static const Color chatPurple = Color(0xFFAF52DE);
  static const Color chatGreen = Color(0xFF34C759);

  // Story colors
  static const Color storyRing = Color(0xFF00C6FF);
  static const Color storyRingEnd = Color(0xFF0072FF);

  // Gradient colors
  static const LinearGradient snapGradient = LinearGradient(
    colors: [Color(0xFFFFFC00), Color(0xFFFFA500)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFFDA22FF), Color(0xFF9733EE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Dark mode specific
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkCard = Color(0xFF2C2C2E);
  static const Color darkDivider = Color(0xFF3A3A3C);
}
