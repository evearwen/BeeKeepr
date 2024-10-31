import 'package:flutter/material.dart';
import 'package:bee_keepr_app/src/hive_data/hive_item.dart';

class Hives extends StatefulWidget {
  const Hives({super.key});

  @override
  _HivesState createState() => _HivesState();
}

class _HivesState extends State<Hives> {
  // List of hive titles (initially empty or with sample data)
  final List<String> hiveTitles = ['Hive 1', 'Hive 2', 'Hive 3', 'Hive 4'];

  void _addNewHive() {
    setState(() {
      hiveTitles.add('Hive ${hiveTitles.length + 1}');
    });
  }

  void _deleteHive(int index) {
    setState(() {
      hiveTitles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE9AB17),
        title: const Text(
          "Hive",
          style: TextStyle(fontSize: 50, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: hiveTitles.length,
          itemBuilder: (context, index) {
            final title = hiveTitles[index];
            return Dismissible(
              key: Key(title),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                _deleteHive(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$title deleted')),
                );
              },
              child: ListTile(
                title: Text(title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HiveItem(title: title),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE9AB17),
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
          ),
          onPressed: _addNewHive,
          child: const Text("New Hive", style: TextStyle(fontSize: 30)),
        ),
      ),
    );
  }
}
