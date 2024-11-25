import 'package:flutter/material.dart';
import 'package:bee_keepr_app/src/hive_data/hive_item.dart';
import 'package:bee_keepr_app/src/hive_data/hive_edit.dart';

///                         Hives
/// +--------------------------------------------------------------+
/// | This is the main page for the Hives feature. It displays     |
/// | all of a Users hives. From this page a user can create new   |
/// | hives, delete hives, edit hives, and view their entries.     |
/// +--------------------------------------------------------------+

class Hives extends StatefulWidget {
  const Hives({super.key});

  @override
  _HivesState createState() => _HivesState();
}

class _HivesState extends State<Hives> {
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
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HiveEdit()),
            );
            //! Will have to add a check to see if edit hive was called from Hives page or HiveItem
            //! If its called from Hives Page we would run the below and pass in the title as input
            //! Otherwise we want to edit the existing hive
            _addNewHive();
          },
          child: const Text("New Hive", style: TextStyle(fontSize: 30)),
        ),
      ),
    );
  }
}
