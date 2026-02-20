import 'package:flutter/material.dart';

class CustomErrorMessageLoading extends StatelessWidget {
  final String errorMessage;
  final Function() onRefresh;

  const CustomErrorMessageLoading({
    super.key,
    required this.errorMessage,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: onRefresh, child: const Text('Retry')),
        ],
      ),
    );
  }
}
