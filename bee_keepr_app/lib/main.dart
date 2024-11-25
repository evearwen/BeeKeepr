import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'src/app.dart';

///                           Main
/// +--------------------------------------------------------------+
/// | The entry point of the application. The firebase BaaS is     |
/// | initialized here before the main app starts.                 |
/// +--------------------------------------------------------------+

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
