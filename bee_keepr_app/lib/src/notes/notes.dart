import 'package:flutter/material.dart';
import 'note_item.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final List<String> NoteTitles = ['Note 1', 'Note 2', 'Note 3', 'Note 4'];

  void _addNewNote() {
  setState(() {
    NoteTitles.add('Note ${NoteTitles.length + 1}');
  });

  //edited so that users will be sent to the note page when creating a new note instead of staying in the note menu
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NoteItem(
        title: 'Note ${NoteTitles.length}', 
        content: '', 
        onDelete: () {
          setState(() {
            NoteTitles.removeAt(NoteTitles.length - 1);
          });
        },
        onTitleChanged: (newTitle) {  
          setState(() {
            NoteTitles[NoteTitles.length - 1] = newTitle; 
          });
        },
      ),
    ),
  );
}


  //functionality to update note names
   void _updateNoteTitle(int index, String newTitle) { 
    setState(() {
      NoteTitles[index] = newTitle; 
    });
  }

  void _deleteNoteAt(int index) {
    setState(() {
      NoteTitles.removeAt(index);
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
          "Note",
          style: TextStyle(fontSize: 50, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: NoteTitles.length,
          itemBuilder: (context, index) {
            final title = NoteTitles[index];
            return Dismissible(
              key: Key(title),
              direction: DismissDirection.horizontal, //left and right functionality
              background: Container(
                color: Colors.blue, 
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.edit, color: Colors.white), 
              ),
              secondaryBackground: Container(
                color: Colors.red, 
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  _deleteNoteAt(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title deleted')),
                  );
                
                } else if (direction == DismissDirection.startToEnd) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteItem(
                        title: title,
                        content: '',
                        onDelete: () => _deleteNoteAt(index),
                        onTitleChanged: (newTitle) => _updateNoteTitle(index, newTitle),
                      ),
                    ),
                  );
                }
                return false;
              },
              child: ListTile(
                title: Text(title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteItem(
                        title: title,
                        content: '',
                        onDelete: () => _deleteNoteAt(index),
                        onTitleChanged: (newTitle) => _updateNoteTitle(index, newTitle),
                      ),
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
          onPressed: _addNewNote,
          child: const Text("New Note", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
