import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<Map<String, String>> loadPageText(String pageName) async {
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
