import 'package:flutter/material.dart';

class PagginationWrapper extends StatelessWidget {
  const PagginationWrapper({super.key, required this.child, required this.onLoadMore});
  final Widget child;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(child:  child,
    onNotification: (notification) {
     if (notification is ScrollEndNotification && 
            notification.metrics.extentAfter < 200) {
          onLoadMore();
        }
      return true;
    },
    );
  }
}