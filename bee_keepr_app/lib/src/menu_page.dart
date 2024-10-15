import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9AB17),
      appBar: AppBar(
          backgroundColor: const Color(0xFFE9AB17),
          automaticallyImplyLeading: false,
          title: const Padding(
            padding: EdgeInsets.only(left: 200.0, top: 0),
            child: Text("BeeKeepr", style: TextStyle(fontSize: 50)),
          )),
      body: const Center(
        child: Text(
          'BEEKEEPR MENU',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
