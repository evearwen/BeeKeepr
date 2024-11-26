import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io'; // For File class
import '../globals.dart' as globals;

///                       Entry Item
/// +--------------------------------------------------------------+
/// | This is the page for entry items. It contains all            |
/// | information pertaining to an entry created by a user and     |
/// | displays it. The user can also edit the entry to alter the   |
/// | data and save it.                                            |
/// +--------------------------------------------------------------+

class EntryItem extends StatefulWidget {
  final String title;
  final String hiveId; // Add hiveId

  const EntryItem({super.key, required this.title, required this.hiveId});

  @override
  _EntryItemState createState() => _EntryItemState();
}

class _EntryItemState extends State<EntryItem> {
  final TextEditingController entryNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController tempController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  String selectedWeather = 'Clear'; // Default value for the dropdown
  final List<String> tags = globals.tags;
  final List<String> selectedTags = [];

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  void toggleTag(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  void saveEntry(String hiveId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be signed in to create notes.')),
      );
      return;
    }

    // Collect data from your controllers and widgets
    String entryName = entryNameController.text.trim();
    String date = dateController.text.trim();
    String location = locationController.text.trim();
    String notes = notesController.text.trim();
    String weather = selectedWeather;
    double? temp = double.tryParse(tempController.text.trim());

    //! Need to actually save the bools somehow
    bool seenQueen = true;
    bool noDiseases = false;
    bool honey = true;
    bool noStressors = false;

    // Prepare the data as a Map
    Map<String, dynamic> entryData = {
      'uid': user.uid,
      'Title': entryName,
      'Date': date,
      'Location': location,
      'Notes': notes,
      'Weather': weather,
      'Temp': temp ?? 0,
      'SeenQueen': seenQueen,
      'NoDiseases': noDiseases,
      'Honey': honey,
      'NoStressors': noStressors,
      'Tags': selectedTags,
      'hiveId': hiveId,
    };

    try {
      // Save entry to the `entries` collection
      DocumentReference entryRef =
          await FirebaseFirestore.instance.collection('entries').add(entryData);

      // Update the Hive document to include this entry
      await FirebaseFirestore.instance.collection('hives').doc(hiveId).update({
        'Entries': FieldValue.arrayUnion([
          {'entryId': entryRef.id, 'entryTitle': entryName} // Entry metadata
        ])
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Entry saved successfully!')),
      );

      Navigator.pop(context); // Go back to the previous page
    } catch (e) {
      print("Error saving entry: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save entry. Please try again.')),
      );
    }
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.black),
            onPressed: () {
              // Delete action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(entryNameController, 'Entry Name'),
            _buildTextField(dateController, 'Date'),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DropdownButtonFormField<String>(
                      value: selectedWeather,
                      decoration: InputDecoration(
                        labelText: 'Weather',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      items: [
                        'Clear',
                        'Partly Cloudy',
                        'Cloudy',
                        'Drizzle',
                        'Rainy',
                        'Stormy',
                        'Snowy',
                        'Foggy'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedWeather = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    tempController,
                    'Temp [°F]',
                    isNumber: true,
                  ),
                ),
              ],
            ),
            _buildTextField(locationController, 'Location'),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatusToggle(label: 'Seen Queen'),
                _StatusToggle(label: 'No Diseases'),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatusToggle(label: 'Honey'),
                _StatusToggle(label: 'No Stressors'),
              ],
            ),
            const SizedBox(height: 16),
            const Text("Tags",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: tags.map<Widget>((tag) {
                final isSelected = selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (_) => toggleTag(tag),
                  selectedColor: Colors.amber,
                  onDeleted: () {
                    setState(() {
                      tags.remove(tag);
                    });
                  },
                  deleteIcon: const Icon(Icons.close),
                  deleteIconColor: Colors.red,
                  backgroundColor: Colors.amber[100],
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: tagController,
                    decoration: InputDecoration(
                      labelText: 'Add a Tag',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final newTag = tagController.text.trim();
                    if (newTag.isNotEmpty && !tags.contains(newTag)) {
                      setState(() {
                        tags.add(newTag);
                      });
                      tagController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE9AB17),
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField(notesController, 'Notes', maxLines: 4),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ImagePickerWidget(),
                )
              ],
            ),
          ],
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE9AB17),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          onPressed: () => saveEntry(widget.hiveId),
          child: const Text("Save Entry", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

class _StatusToggle extends StatefulWidget {
  final String label;
  const _StatusToggle({required this.label});

  @override
  _StatusToggleState createState() => _StatusToggleState();
}

class _StatusToggleState extends State<_StatusToggle> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: isChecked ? Colors.green : Colors.red,
            child: Icon(
              isChecked ? Icons.thumb_up : Icons.thumb_down,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(widget.label),
      ],
    );
  }
}

class ImagePickerWidget extends StatefulWidget {
  // You don't need to pass any callback anymore
  ImagePickerWidget({Key? key}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  PlatformFile? _file; // Store the selected image

  // Function to pick an image file
  Future<void> _pickImage() async {
    try {
      // Allow the user to pick an image file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image, // Restrict file selection to images
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _file = result.files.first; // Store the first selected file
        });
      } else {
        // Handle the case where no file is selected
        print("No file selected");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Display the selected image, or a message if no image is selected
        _file == null
            ? Text('No image selected.')
            : Column(
                children: [
                  // Display the image using its bytes
                  Image.memory(
                    _file!.bytes!, // Use the image bytes to display it
                    // width: 300,  // Set the width for the image
                    // height: 300,  // Set the height for the image
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                  Text('File name: ${_file!.name}'), // Show the file name
                ],
              ),
        SizedBox(height: 20),
        // Button to pick an image from the file picker
        ElevatedButton(
          onPressed: _pickImage,
          child: Text('Pick Image'),
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}
