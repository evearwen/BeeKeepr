import 'package:flutter/material.dart';
import 'menu_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9AB17),
      appBar: AppBar(
          backgroundColor: const Color(0xFFE9AB17),
          title: const Padding(
            padding: EdgeInsets.only(left: 200.0, top: 0),
            child: Text("BeeKeepr", style: TextStyle(fontSize: 50)),
          )),
      body: Padding(
        padding: const EdgeInsets.only(
            left: 150, top: 100), // Add padding to make it look better
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items to the start
          children: [
            Image.asset("assets/images/3.0x/flutter_logo.png"),
            const Text(
              "Username",
              style: TextStyle(fontSize: 16), // Label for the username
            ),
            const SizedBox(
                height: 8), // Space between the label and input field
            const SizedBox(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Enter your username',
                  ),
                )),
            const SizedBox(
                height: 16), // Space between the username and password fields
            const Text(
              "Password",
              style: TextStyle(fontSize: 16), // Label for the password
            ),
            const SizedBox(
                height: 8), // Space between the label and input field
            const SizedBox(
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Enter your password',
                  ),
                )),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  const AlertDialog(semanticLabel: "button pressed");

                  // handle Login Attempt
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MenuPage()),
                  );
                },
                child: const Text("Log In"))
          ],
        ),
      ),
    );
  }
}
