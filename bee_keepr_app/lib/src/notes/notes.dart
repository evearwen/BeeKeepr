import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'note_item.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  var db = FirebaseFirestore.instance;

  void _addNewNote() async {
    await db.collection('notes').add({
      'Title': 'New Note',
      'Content': '',
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
          stream: db.collection('notes').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
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
                    _deleteNoteAt(note.id);
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
                            onDelete: () => _deleteNoteAt(note.id),
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
      ),
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
