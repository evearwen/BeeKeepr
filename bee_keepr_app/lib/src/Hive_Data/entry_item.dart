import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EntryItem extends StatefulWidget {
  final String title;
  const EntryItem({super.key, required this.title});

  @override
  _EntryItemState createState() => _EntryItemState();
}

class _EntryItemState extends State<EntryItem> {
  final TextEditingController entryNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController tempController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String selectedWeather = 'Clear'; // Default value for the dropdown
  String date = DateFormat('MM/dd/yyyy').format(DateTime.now());

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
              _buildTextField(dateController, date),
              
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
              _buildTextField(notesController, 'Notes', maxLines: 4),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, size: 50),
                    onPressed: () {
                      // Camera action
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.photo, size: 50),
                    onPressed: () {
                      // Gallery action
                    },
                  ),
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
            onPressed: () {},
            child: const Text("Save Entry", style: TextStyle(fontSize: 18)),
          ),
        ));
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
