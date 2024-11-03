import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final dynamic username;
  final dynamic firstName;
  final dynamic lastName;
  final dynamic email;

  const SettingsPage(
      {super.key,
      this.username = "The African Ambusher",
      this.firstName = "Killa",
      this.lastName = "B.",
      this.email = "BeeWarlord@hotmail.com"});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                widget.username,
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
            const SizedBox(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Enter New First Name',
                  ),
                )),
            const SizedBox(height: 10),
            // Last Name Input
            const Text(
              "New Last Name",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Enter New Last Name',
                  ),
                )),
            const SizedBox(height: 10),
            // Password Input
            const Text(
              "New Last Name",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Enter New Password',
                  ),
                )),
            const SizedBox(height: 20),
            // Save Changes Button
            const ElevatedButton(
              onPressed: null,
              child: Text(
                "Save Changes",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
