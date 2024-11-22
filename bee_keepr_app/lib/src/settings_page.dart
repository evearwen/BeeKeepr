import 'package:flutter/material.dart';
import 'globals.dart' as globals;

///                       SETTINGS PAGE
/// +---------------------------------------------------------+
/// |The Setting Page is responsible for allowing the user to |
/// |update their profile as well as system of measurement.   |
/// +---------------------------------------------------------+

// Settings Page is not a static class so it needs its
// fluctuating state to be defined using another class
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

// Settings Page State is a modifiable Settings Page
class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isMetric = globals.isMetric;

  void _saveProfileChanges() {
    setState(() {
      if (_firstNameController.text.isNotEmpty) {
        globals.firstName = _firstNameController.text;
      }
      if (_lastNameController.text.isNotEmpty) {
        globals.lastName = _lastNameController.text;
      }
      if (_usernameController.text.isNotEmpty) {
        globals.username = _usernameController.text;
      }
      if (_passwordController.text.isNotEmpty) {
        globals.password = _passwordController.text;
      }
    });
  }

  void _toggleMetricPreference(bool value) { 
    setState(() { 
      _isMetric = value; 
      globals.isMetric = value; 
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
          Center(
            child: Image.asset( // Displays Logo
              "assets/images/beekeepr_logo.png",
              scale: 6,
            ),
          ),
            const SizedBox(height: 15),
            Container( // Displays current First and Last name
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
            Container( // Displays current Username
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
            const Text(
              "New First Name",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox( // Handles user input for firstname
                width: 400,
                child: TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                      labelText: "Enter New First Name Here",
                      fillColor: Colors.white,
                      filled: true),
                )),
            const SizedBox(height: 10),
            const Text(
              "New Last Name",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox( // Handles user input for lastname
                width: 400,
                child: TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                      labelText: "Enter New Last Name Here",
                      fillColor: Colors.white,
                      filled: true),
                )),
            const SizedBox(height: 10),
            const Text(
              "New Username",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox( // Handles user input for username
                width: 400,
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                      labelText: "Enter New Username Here",
                      fillColor: Colors.white,
                      filled: true),
                )),
            const SizedBox(height: 10),
            const Text( // Handles user input for password
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
            const SizedBox(height: 9),
            const SizedBox(height: 18),
            Row( // Measurement system toggle
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Use Metric System",
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: _isMetric,
                  onChanged: _toggleMetricPreference,
                  activeColor: Colors.green,
                ),
              ],
            ),
            ElevatedButton( // Save Changes Button
              onPressed: _saveProfileChanges,
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
