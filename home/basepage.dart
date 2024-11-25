import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final String title;

  const BasePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Halaman $title')),
    );
  }
}