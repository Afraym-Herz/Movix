import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      try {
        action();
      } catch (e) {
        log('Error executing debounced action: $e');
      }
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
