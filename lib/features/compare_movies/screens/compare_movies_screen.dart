import 'package:flutter/material.dart';

class CompareMoviesScreen extends StatelessWidget {
  const CompareMoviesScreen({super.key});

  static const String routeName = '/compare_movies';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Movies'),
      ),
      body: const Center(
        child: Text('Compare Movies'),
      ),
    );
  }
}