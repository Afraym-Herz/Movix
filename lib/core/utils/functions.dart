import 'package:flutter/material.dart';
import 'package:movix/features/auth/screens/widgets/custom_text_form_field.dart';

double getScaleFactor(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;
  if (width < 600) {
    return width / 400;
  } else if (width < 900) {
    return width / 700;
  } else {
    return width / 1000;
  }
}

double getResponsiveFontSize(
  BuildContext context, {
  required double baseFontSize,
}) {
  final scaleFactor = getScaleFactor(context);
  double responsiveFontSize = baseFontSize * scaleFactor;

  double minFontSize = baseFontSize * 0.8;
  double maxFontSize = baseFontSize * 1.2;
  return responsiveFontSize.clamp(minFontSize, maxFontSize);
}

String? validatorFunction(
  String? value, {
  String? labelText,
  required FieldType fieldType,
}) {
  if (value == null || value.isEmpty) {
    return 'Must enter $labelText';
  }
  if (fieldType == FieldType.email) {
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
  }
  if (fieldType == FieldType.age) {
    final age = int.tryParse(value);
    if (age == null || age < 2 || age > 120) {
      return 'Enter a valid age';
    }
  }
  if (fieldType == FieldType.password) {
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
  }
  if (fieldType == FieldType.newPassword) {
    if (value.length < 6 ||
        !value.contains(RegExp(r'[A-Z]')) ||
        !value.contains(RegExp(r'[0-9]')) ||
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain:\n'
          '• At least 6 characters\n'
          '• One uppercase letter\n'
          '• One number\n'
          '• One special character';
    }
  }
  if (fieldType == FieldType.name) {
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
  }

  return null;
}

Route<dynamic> buildCinematicRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 650),
    reverseTransitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutExpo,
        reverseCurve: Curves.easeInExpo,
      );

      final fade = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

      final scale = Tween<double>(begin: 0.96, end: 1.0).animate(curved);

      final slide = Tween<Offset>(
        begin: const Offset(0, 0.04),
        end: Offset.zero,
      ).animate(curved);

      return FadeTransition(
        opacity: fade,
        child: SlideTransition(
          position: slide,
          child: ScaleTransition(
            scale: scale,
            child: child,
          ),
        ),
      );
    },
  );
}
