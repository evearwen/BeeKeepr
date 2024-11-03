import 'package:bee_keepr_app/src/about_page.dart';
import 'package:bee_keepr_app/src/notes/notes.dart';
import 'package:bee_keepr_app/src/learn_page.dart';
import 'package:bee_keepr_app/src/settings_page.dart';
import 'package:flutter/material.dart';

// creates Hexagonal Path
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

// Matches Hexagon to Button
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
          width: 140, // Set the width of the hexagonal button
          height: 120, // Set the height of the hexagonal button
          color: Colors.white, // Background color of the button
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
                    left: 80,
                    top: 20,
                    child: Image.asset("assets/images/3.0x/flutter_logo.png")),
                Positioned(
                  top: hiveOffsetTop,
                  child: Column(
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
                            // Exit App
                          },
                          label: "Exit"),
                      SizedBox(height: hexSpace),
                      HexagonalButton(
                          onPressed: () {
                            // Hive Data Navigation
                          },
                          label: "Hives"),
                      SizedBox(height: hexSpace),
                      HexagonalButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsPage()),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Notes())); // Notes Navigation
                            },
                            label: "Notes"),
                        SizedBox(height: hexSpace),
                        HexagonalButton(
                            onPressed: () {
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
