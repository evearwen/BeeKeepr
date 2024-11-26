import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'note_item.dart';

///                         Notes
/// +--------------------------------------------------------------+
/// | This is the main page for the notes feature. It queries the  |
/// | database based off any filters or searches to populate a     |
/// | list of all related notes. If no queries are supplied it     |
/// | retrieves all notes created by a user and lists them.        |
/// +--------------------------------------------------------------+

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  var db = FirebaseFirestore.instance;

  void _addNewNote() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be signed in to create notes.')),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('notes').add({
      'uid': user.uid,
      'Title': 'New Note',
      'Content': '',
      'CreatedAt': Timestamp.now(),
    });
  }

  void _deleteNoteAt(String noteId) async {
    await db.collection('notes').doc(noteId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFE9AB17),
        title: const Text(
          "Notes",
          style: TextStyle(fontSize: 50, color: Colors.black),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notes')
                .where('uid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final notes = snapshot.data!.docs;

              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  final title = note['Title'];
                  final content = note['Content'];
                  return Dismissible(
                    key: Key(note.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      FirebaseFirestore.instance
                          .collection('notes')
                          .doc(note.id)
                          .delete();
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
                            builder: (context) => NoteItem(
                              title: title,
                              content: content,
                              noteId: note.id,
                              onDelete: () => FirebaseFirestore.instance
                                  .collection('notes')
                                  .doc(note.id)
                                  .delete(),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE9AB17),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          onPressed: _addNewNote,
          child: const Text("New Note", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
