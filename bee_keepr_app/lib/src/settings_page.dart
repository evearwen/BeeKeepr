import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _firstNameController =
      TextEditingController(); // Controller to manage the TextField
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String getGlobalName() {
    return globals.firstName;
  }

  void _getUserInput() {
    setState(() {
      if (_firstNameController.text.isNotEmpty) {
        globals.firstName = _firstNameController.text;
      }
      if (_lastNameController.text.isNotEmpty) {
        globals.lastName = _lastNameController.text;
      }
      if (_passwordController.text.isNotEmpty) {
        globals.password = _passwordController.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9AB17),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE9AB17),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 100),
                // User Profile Picture
                child: Image.asset("assets/images/3.0x/flutter_logo.png")),
            const SizedBox(height: 20),
            //
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${globals.lastName}, ${globals.firstName}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                globals.username,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Personal Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            // First Name Input
            const Text(
              "New First Name",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
                width: 400,
                child: TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                      labelText: "Enter New First Name Here",
                      fillColor: Colors.white,
                      filled: true),
                )),
            const SizedBox(height: 10),
            // Last Name Input
            const Text(
              "New Last Name",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
                width: 400,
                child: TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                      labelText: "Enter New Last Name Here",
                      fillColor: Colors.white,
                      filled: true),
                )),

            const SizedBox(height: 10),
            const SizedBox(height: 10),
            // Password Input
            const Text(
              "New Password",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
                width: 400,
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: "Enter New Password Here",
                      fillColor: Colors.white,
                      filled: true),
                )),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            // Save Changes Button
            ElevatedButton(
              onPressed: _getUserInput,
              child: const Text(
                "Save Changes",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
