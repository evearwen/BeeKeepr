import 'package:bee_keepr_app/src/about_page.dart';
import 'package:bee_keepr_app/src/login_page.dart';
import 'package:bee_keepr_app/src/notes/notes.dart';
import 'package:bee_keepr_app/src/learn_page.dart';
import 'package:bee_keepr_app/src/settings_page.dart';
import 'package:bee_keepr_app/src/Hive_Data/Hives.dart';
import 'package:flutter/material.dart';

///                         MENU PAGE
/// +----------------------------------------------------------+
/// |The Menu Page is the main page of the application which   |
/// |includes hexagonal menu buttons. This page has navigation |
/// |to every other page in the application.                   |
/// +----------------------------------------------------------+

// Main class for Menu Page
class MenuPage extends StatelessWidget {
  static double hexSpace = 17.0; // determines gap between hex buttons
  static double hiveOffsetTop = 180.0; // y-offset of button structure
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE9AB17),
        appBar: AppBar(
            automaticallyImplyLeading: false,
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
          child: SizedBox(
              width: 400,
              height: 800,
              child: Stack(children: [
                Positioned(
                    left: 125,
                    top: 40,
                    child: Image.asset(
                      "assets/images/beekeepr_logo.png",
                      scale: 6,
                    )),
                Positioned(
                  top: hiveOffsetTop,
                  child: Column(// Column for Hexagonal Buttons
                      // Hexgrid Column 1
                      children: [
                    const SizedBox(height: 150),
                    HexagonalButton(
                        onPressed: () {
                          // Forum Navigation
                        },
                        label: "Forum"),
                    SizedBox(height: hexSpace),
                    HexagonalButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LearnPage()),
                          );
                        },
                        label: "Learn"),
                  ]),
                ),
                SizedBox(width: hexSpace),
                Positioned(
                  top: hiveOffsetTop,
                  left: 120,
                  child: Column(
                    // Hexgrid Column 2
                    children: [
                      const SizedBox(height: 80),
                      HexagonalButton(
                          onPressed: () {
                            // Return to Login Page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          label: "Exit"),
                      SizedBox(height: hexSpace),
                      HexagonalButton(
                          onPressed: () {
                            // Navigate to Hive Data Page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Hives()),
                            );
                          },
                          label: "Hives"),
                      SizedBox(height: hexSpace),
                      HexagonalButton(
                          onPressed: () {
                            // Navigate to Settings Page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()),
                            );
                          },
                          label: "Settings"),
                    ],
                  ),
                ),
                SizedBox(width: hexSpace),
                Positioned(
                    top: hiveOffsetTop,
                    left: 240,
                    child: Column(
                      // Hexgrid Column 3
                      children: [
                        const SizedBox(height: 150),
                        HexagonalButton(
                            onPressed: () {
                              // Navigate to Notes Page
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Notes()));
                            },
                            label: "Notes"),
                        SizedBox(height: hexSpace),
                        HexagonalButton(
                            onPressed: () {
                              // Navigate to About Page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AboutPage()),
                              );
                            },
                            label: "About")
                      ],
                    ))
              ])),
        ));
  }
}

// creates Hexagonal Path that gets used for the Hexagon buttons
class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;

    path.moveTo(width * 0.25, 0); // Top-left
    path.lineTo(width * 0.75, 0); // Top-right
    path.lineTo(width, height * 0.5); // Right middle
    path.lineTo(width * 0.75, height); // Bottom-right
    path.lineTo(width * 0.25, height); // Bottom-left
    path.lineTo(0, height * 0.5); // Left middle
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Binds the Hexagon to each Button
class HexagonalButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const HexagonalButton(
      {super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Make the button tappable
      child: ClipPath(
        clipper: HexagonClipper(), // Apply the custom hexagon shape
        child: Container(
          // Settings for the hexagonal button
          width: 140,
          height: 120,
          color: Colors.white,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFFE9AB17),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
