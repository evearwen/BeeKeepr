import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

Future<Map<String, String>> getPageInfo(String pageName) async {
  // load JSON file
  final data = await rootBundle.loadString('json/texts.json');
  Map<String, dynamic> jsonData = json.decode(data);
  // return all values stored under "AboutPage"
  final pageText = jsonData[pageName];
  if (pageText != null && pageText is Map<String, dynamic>) {
    return Map<String, String>.from(pageText);
  } else {
    return {};
  }
}

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
      body: Padding(
          padding: const EdgeInsets.all(20),
          // child: Text("App Description Goes Here"),
          child: FutureBuilder(
              future: getPageInfo("about"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!["AppInfo"] ?? "Unable to Read String",
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
