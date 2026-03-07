import 'package:flutter/material.dart';
import 'package:movix/core/widgets/custom_snack_bar_widget.dart';

class GlobalSnackbar {
  static OverlayEntry? _currentEntry;

  static void show(BuildContext context, String message) {
    // 1. Remove the old snackbar if it exists
    _currentEntry?.remove();
    _currentEntry = null;

    // 2. Get the highest overlay in the app
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    _currentEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: 24.0,
          left: 24.0,
          right: 24.0,
          child: Material(
            color: Colors.transparent,
            child: CustomSnackbarWidget(
              message: message,
              onDismiss: () {
                _currentEntry?.remove();
                _currentEntry = null;
              },
            ),
          ),
        );
      },
    );

    // 4. Insert it!
    overlay.insert(_currentEntry!);
  }
}