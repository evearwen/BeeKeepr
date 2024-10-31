import 'package:flutter/material.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  // Manage the visibility of submenus
  bool _isMathExpanded = false;
  bool _isScienceExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFFE9AB17),
          title: const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 0),
            child: Text("Lessons",
                style: TextStyle(fontSize: 50, color: Colors.black)),
          )),
      body: Row(
        children: [
          // Vertical menu bar on the left
          Container(
            width: 250,
            color: const Color(0xFFE9AB17),
            child: Column(
              children: [
                MenuItem(
                  title: 'Overview',
                  onTap: () {
                    print('Selected: Home');
                  },
                ),
                ExpandableMenuItem(
                  title: 'Lesson 1',
                  isExpanded: _isMathExpanded,
                  onTap: () {
                    setState(() {
                      _isMathExpanded = !_isMathExpanded; 
                    });
                  },
                  submenu: [
                    MenuItem(title: 'Lesson 1.1', onTap: () => print('Lesson 1.1')),
                    MenuItem(title: 'Lesson 1.2', onTap: () => print('Lesson 1.2')),
                  ],
                ),
                ExpandableMenuItem(
                  title: 'Lesson 2',
                  isExpanded: _isScienceExpanded,
                  onTap: () {
                    setState(() {
                      _isScienceExpanded = !_isScienceExpanded;
                    });
                  },
                  submenu: [
                    MenuItem(title: 'Lesson 2.1', onTap: () => print('Lesson 2.1')),
                    MenuItem(title: 'Lesson 2.2', onTap: () => print('Lesson 2.2')),
                  ],
                ),
                MenuItem(
                  title: 'Lesson 3',
                  onTap: () {
                    print('Lesson3');
                  },
                ),
              ],
            ),
          ),
          // Main content area
          Expanded(
            child: Center(
              child: Text('ADD LESSON STUFF HERE!'),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  MenuItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class ExpandableMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isExpanded;
  final List<MenuItem> submenu;

  ExpandableMenuItem({
    required this.title,
    required this.onTap,
    required this.isExpanded,
    required this.submenu,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: onTap,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        if (isExpanded)
          Column(
            children: submenu
                .map((item) => Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: item,
                    ))
                .toList(),
          ),
      ],
    );
  }
}
