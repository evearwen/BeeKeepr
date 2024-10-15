import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFFE9AB17),
          title: const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 0),
            child: Text("About",
                style: TextStyle(fontSize: 50, color: Colors.black)),
          )),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text("App Description Goes Here"),
      ),
    );
  }
}
