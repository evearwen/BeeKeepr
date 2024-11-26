import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bee_keepr_app/src/Hive_Data/hive_edit.dart';
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
  final String hiveId; // Pass the Hive document ID
  final String title;

  const HiveItem({Key? key, required this.hiveId, required this.title})
      : super(key: key);

  @override
  _HiveItemState createState() => _HiveItemState();
}

class _HiveItemState extends State<HiveItem> {
  DocumentSnapshot? hiveData;

  @override
  void initState() {
    super.initState();
    _fetchHiveData();
  }

  Future<void> _fetchHiveData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('hives')
          .doc(widget.hiveId)
          .get();
      setState(() {
        hiveData = snapshot;
      });
    } catch (e) {
      print('Error fetching hive data: $e');
    }
  }

  Stream<QuerySnapshot> fetchHiveEntries() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream
          .empty(); // Return an empty stream if the user is not signed in
    }
    return FirebaseFirestore.instance
        .collection('entries')
        .where('uid',
            isEqualTo: user.uid) // Filter by the authenticated user's ID
        .where('hiveId', isEqualTo: widget.hiveId) // Match the hive ID
        .snapshots();
  }

  void _addNewEntry() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be signed in to add entries.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EntryItem(
          title: 'New Entry',
          hiveId: widget.hiveId, // Pass the hiveId to the EntryItem
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE9AB17),
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 30, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Edit Hive Action (Add your existing editing functionality here)
            },
          ),
        ],
      ),
      body: hiveData == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: fetchHiveEntries(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final entries = snapshot.data!.docs;

                      if (entries.isEmpty) {
                        return const Center(
                          child: Text("No entries found for this hive."),
                        );
                      }

                      return ListView.builder(
                        itemCount: entries.length,
                        itemBuilder: (context, index) {
                          final entry = entries[index];

                          return ListTile(
                            title: Text(entry['Title'] ?? 'No Title'),
                            subtitle: Text(entry['Date'] ?? 'No Date'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EntryItem(
                                    title: entry['Title'],
                                    hiveId: widget.hiveId,
                                    entryId: entry.id,
                                  ),
                                ),
                              );
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('entries')
                                    .doc(entry.id)
                                    .delete();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Entry deleted.'),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewEntry,
        backgroundColor: const Color(0xFFE9AB17),
        child: const Icon(Icons.add),
      ),
    );
  }
}
