import 'package:flutter/material.dart';


class BackgroundImageContainer extends StatelessWidget {
  const BackgroundImageContainer({super.key, required this.child});
  final Widget child ;
  @override
  Widget build(BuildContext context) {
    return  Container(
      
     
      child: child,
    );
  }
}
