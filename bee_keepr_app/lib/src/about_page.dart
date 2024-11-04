import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<String> loadDescriptionText() async {
    return await rootBundle.loadString('text/app_description.txt');
  }

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
      body: Padding(
          padding: const EdgeInsets.all(20),
          // child: Text("App Description Goes Here"),
          child: FutureBuilder(
              future: loadDescriptionText(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data ?? "",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  );
                } else {
                  return const Text(
                    "Error loading text",
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  );
                }
              })),
    );
  }
}
