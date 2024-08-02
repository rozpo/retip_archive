import 'package:flutter/material.dart';

class RetipLayout extends StatelessWidget {
  final String title;
  final Widget body;

  const RetipLayout({
    required this.title,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
    );
  }
}
