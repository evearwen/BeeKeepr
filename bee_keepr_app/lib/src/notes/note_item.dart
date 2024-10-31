import 'package:flutter/material.dart';

class NoteItem extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback onDelete;

  const NoteItem(
      {super.key,
      required this.title,
      required this.content,
      required this.onDelete});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9AB17),
        title: _isEditing
            ? TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                decoration: const InputDecoration(border: InputBorder.none),
              )
            : Text(
                _titleController.text,
                style: const TextStyle(color: Colors.black),
              ),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _toggleEditMode,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isEditing
            ? TextField(
                controller: _contentController,
                maxLines: null,
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
