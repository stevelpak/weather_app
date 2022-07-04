import 'package:flutter/material.dart';

// Colors

Color topShadowClr = const Color(0xFF9A60E5).withOpacity(0.16);
Color locationClr = const Color(0xFF6764EF);
Color topCityColor = const Color(0xFF25272E);
Color dateTextColor = const Color(0xFFF0F0F0);
Color humidityGoodClr = const Color(0xFF2DBE8D);
Color humidityHmColor = const Color(0xFFF9CF5F);
Color humidityBadClrg = const Color(0xFFFF7676);
Color notActiveDateColor = const Color(0xFFB5B5B5);
Color white = Colors.white;
Color black = Colors.black;

// Gradients

LinearGradient bgGradient = LinearGradient(
  colors: [
    const Color(0xFFFEF7FF).withOpacity(0),
    const Color(0xFFFCEBFF).withOpacity(1),
  ],
  begin: const Alignment(0, -1),
  end: const Alignment(0, 0),
);

LinearGradient stateGradient = const LinearGradient(
  colors: [
    Color(0xFFE662E5),
    Color(0xFF5364F0),
  ],
);

LinearGradient textGradient = const LinearGradient(
  colors: [
    Color(0xFFFFFFFF),
    Color(0xFFD2C4FF),
  ],
);

// BoxShadows

BoxShadow topBoxShadow = BoxShadow(
  color: topShadowClr,
  offset: const Offset(0, 5),
  blurRadius: 30,
);

// BoxDecorations

BoxDecoration activeDay = BoxDecoration(
  borderRadius: BorderRadius.circular(33),
  gradient: stateGradient,
);

BoxDecoration noActiveDay = BoxDecoration(
  borderRadius: BorderRadius.circular(33),
);
