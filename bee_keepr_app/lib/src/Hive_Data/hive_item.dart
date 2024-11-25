import 'package:flutter/material.dart';
import 'package:bee_keepr_app/src/hive_data/entry_item.dart';

///                       Hives Item
/// +--------------------------------------------------------------+
/// | This is the page for the hive items. It contains all         |
/// | information pertaining to each individual hive created by a  |
/// | user. It queries the database based off any filters or       |
/// | searches to populate a list of all related entries. If no    |
/// | queries are supplied it retrieves all entries created by a   |
/// | user for the hive and lists them. You can also create,       |
/// | edit, and delete entries which are stored as entry items.    |
/// +--------------------------------------------------------------+

class HiveItem extends StatefulWidget {
  final String title;
  const HiveItem({super.key, required this.title});

  @override
  _HiveItemState createState() => _HiveItemState();
}

class _HiveItemState extends State<HiveItem> {
  // List of entry titles within the hive (initially empty or with sample data)
  final List<String> entryTitles = ['Entry 1', 'Entry 2', 'Entry 3'];

  void _addNewEntry() {
    setState(() {
      final newTitle = 'Entry ${entryTitles.length + 1}';
      entryTitles.add(newTitle);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EntryItem(title: newTitle),
        ),
      );
    });
  }

  void _deleteEntry(int index) {
    setState(() {
      entryTitles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE9AB17),
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 50, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: entryTitles.length,
          itemBuilder: (context, index) {
            final title = entryTitles[index];
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
                _deleteEntry(index);
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
                      builder: (context) => EntryItem(title: title),
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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          onPressed: _addNewEntry,
          child: const Text("New Entry", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
