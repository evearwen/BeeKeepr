import 'package:flutter/material.dart';
import 'package:bee_keepr_app/src/login_page.dart';

///                           App
/// +--------------------------------------------------------------+
/// | The start of the app. Opens the login page for the users     |
/// | and initializes any other components if needed.              |
/// +--------------------------------------------------------------+

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
