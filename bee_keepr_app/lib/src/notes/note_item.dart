import 'package:flutter/material.dart';

///                         Notes Item
/// +--------------------------------------------------------------+
/// | This is the page for the note items. It contains the         |
/// | information pertaining to each individual note created by a  |
/// | user. The content and title is passed in from the Note       |
/// | page. It displays the content and also allows them to edit,  |
/// | save, and delete it.                                         |
/// +--------------------------------------------------------------+

class NoteItem extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback onDelete;
  final ValueChanged<String>
      onTitleChanged; //adding so that users can edit note titles
  final bool isNewNote;

  const NoteItem({
    super.key,
    required this.title,
    required this.content,
    required this.onDelete,
    required this.onTitleChanged,
    this.isNewNote = false,
  });

  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.content);
    if (widget.isNewNote) {
      _isEditing = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  //save a new title
  void _saveTitle() {
    if (_isEditing) {
      widget.onTitleChanged(_titleController.text);
      _toggleEditMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9AB17),
        title: _isEditing
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
                child: TextField(
                  controller: _titleController,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              )
            : Text(
                _titleController.text,
                style: const TextStyle(color: Colors.black),
              ),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing ? _saveTitle : _toggleEditMode,
          ),
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.onDelete(); // Call delete callback
                Navigator.pop(context); // Close the page after deleting
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _isEditing
            ? TextField(
                controller: _contentController,
                maxLines: null, // Allow TextField to expand as much as needed
                decoration: const InputDecoration(
                  hintText: 'Enter note details...',
                  border: OutlineInputBorder(),
                ),
              )
            : Text(
                _contentController.text,
                style: const TextStyle(fontSize: 18),
              ),
      ),
    );
  }
}
