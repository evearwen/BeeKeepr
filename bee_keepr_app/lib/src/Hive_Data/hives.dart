import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Stream<QuerySnapshot> fetchHives() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.empty(); // Return an empty stream if not signed in
    }
    return FirebaseFirestore.instance
        .collection('hives')
        .where('uid',
            isEqualTo: user.uid) // Filter by the authenticated user's ID
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE9AB17),
        title: const Text(
          "Hive",
          style: TextStyle(fontSize: 50, color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fetchHives(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final hives = snapshot.data!.docs;

          return ListView.builder(
            itemCount: hives.length,
            itemBuilder: (context, index) {
              final hive = hives[index];
              return Dismissible(
                key: Key(hive.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) async {
                  await FirebaseFirestore.instance
                      .collection('hives')
                      .doc(hive.id)
                      .delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${hive['Title']} deleted')),
                  );
                },
                child: ListTile(
                  title: Text(hive['Title']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HiveItem(
                          hiveId: hive
                              .id, // Pass the Firestore document ID as hiveId
                          title: hive['Title'], // Pass the hive title
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HiveEdit()),
          );
          if (result != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Hive added successfully!')),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
