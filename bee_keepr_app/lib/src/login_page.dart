import 'package:flutter/material.dart';
import 'menu_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9AB17),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFFE9AB17),
          title: const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 0),
            child: Text("BeeKeepr",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          )),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align items to the start
          children: [
            Padding(
                padding:
                    const EdgeInsets.only(left: 0), // Logo Dimensional Offset
                child: Image.asset(
                  "assets/images/beekeepr_logo.png",
                  scale: 5,
                )),
            const SizedBox(height: 20), // Space after Logo
            const Text("Protect the Bees",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            const Text("Protect the World",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 40),
            const Text(
              "Username",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
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
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
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
                  // Handle Login Attempt Here
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
