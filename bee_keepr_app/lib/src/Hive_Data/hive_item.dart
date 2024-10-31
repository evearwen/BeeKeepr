import 'package:flutter/material.dart';

class HiveItem extends StatelessWidget {
  final String title;
  const HiveItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE9AB17),
        title: Text(
          title,
          style: TextStyle(fontSize: 50, color: Colors.black),
        ),
      ),
      body: Center(
        child: Text(
          'Details for $title',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
