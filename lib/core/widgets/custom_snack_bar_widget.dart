import 'package:flutter/material.dart';

class CustomSnackbarWidget extends StatefulWidget {
  final String message;
  final VoidCallback onDismiss;

  const CustomSnackbarWidget({
    Key? key,
    required this.message,
    required this.onDismiss,
  }) : super(key: key);

  @override
  State<CustomSnackbarWidget> createState() => _CustomSnackbarWidgetState();
}

class _CustomSnackbarWidgetState extends State<CustomSnackbarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start below screen
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Animate in
    _controller.forward();

    // Auto-dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), dismiss);
  }

  void dismiss() async {
    if (mounted) {
      await _controller.reverse(); // Animate out
      widget.onDismiss();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: dismiss,
            ),
          ],
        ),
      ),
    );
  }
}