import 'package:flutter/material.dart';

class HiveEdit extends StatefulWidget {
  final String? hiveName;
  final String? hiveType;
  final String? hiveColor;
  final String? location;
  final int? numberOfDeeps;
  final int? numberOfSupers;
  final int? numberOfFrames;
  final String? queenBreed;
  final String? queenColor;
  final String? notes;

  const HiveEdit({
    Key? key,
    this.hiveName,
    this.hiveType,
    this.hiveColor,
    this.location,
    this.numberOfDeeps,
    this.numberOfSupers,
    this.numberOfFrames,
    this.queenBreed,
    this.queenColor,
    this.notes,
  }) : super(key: key);

  @override
  _HiveEditState createState() => _HiveEditState();
}

class _HiveEditState extends State<HiveEdit> {
  final TextEditingController _hiveNameController = TextEditingController();
  final TextEditingController _hiveTypeController = TextEditingController();
  final TextEditingController _hiveColorController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _numberOfDeepsController =
      TextEditingController();
  final TextEditingController _numberOfSupersController =
      TextEditingController();
  final TextEditingController _numberOfFramesController =
      TextEditingController();
  final TextEditingController _queenBreedController = TextEditingController();
  final TextEditingController _queenColorController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.hiveName != null) _hiveNameController.text = widget.hiveName!;
    if (widget.hiveType != null) _hiveTypeController.text = widget.hiveType!;
    if (widget.hiveColor != null) _hiveColorController.text = widget.hiveColor!;
    if (widget.location != null) _locationController.text = widget.location!;
    if (widget.numberOfDeeps != null)
      _numberOfDeepsController.text = widget.numberOfDeeps.toString();
    if (widget.numberOfSupers != null)
      _numberOfSupersController.text = widget.numberOfSupers.toString();
    if (widget.numberOfFrames != null)
      _numberOfFramesController.text = widget.numberOfFrames.toString();
    if (widget.queenBreed != null)
      _queenBreedController.text = widget.queenBreed!;
    if (widget.queenColor != null)
      _queenColorController.text = widget.queenColor!;
    if (widget.notes != null) _notesController.text = widget.notes!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New/Edit Hive'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(_hiveNameController, 'Hive Name'),
              _buildTextField(_hiveTypeController, 'Hive Type'),
              _buildTextField(_hiveColorController, 'Hive Color'),
              _buildTextField(_locationController, 'Location'),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField(
                          _numberOfDeepsController, '# of Deeps',
                          isNumber: true)),
                  const SizedBox(width: 8.0),
                  Expanded(
                      child: _buildTextField(
                          _numberOfSupersController, '# of Supers',
                          isNumber: true)),
                  const SizedBox(width: 8.0),
                  Expanded(
                      child: _buildTextField(
                          _numberOfFramesController, '# of Frames',
                          isNumber: true)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField(
                          _queenBreedController, 'Queen Breed')),
                  const SizedBox(width: 8.0),
                  Expanded(
                      child: _buildTextField(
                          _queenColorController, 'Queen Color')),
                ],
              ),
              _buildTextField(_notesController, 'Notes', maxLines: 5),
              const SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE9AB17),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0),
                  ),
                  onPressed: _saveChanges,
                  child: const Text('Save Changes',
                      style: TextStyle(fontSize: 18.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  void _saveChanges() {
    // Implement save functionality here
    // Example: You could call a provider or pass the edited data back via Navigator.pop
    Navigator.of(context).pop({
      'hiveName': _hiveNameController.text,
      'hiveType': _hiveTypeController.text,
      'hiveColor': _hiveColorController.text,
      'location': _locationController.text,
      'numberOfDeeps': int.tryParse(_numberOfDeepsController.text) ?? 0,
      'numberOfSupers': int.tryParse(_numberOfSupersController.text) ?? 0,
      'numberOfFrames': int.tryParse(_numberOfFramesController.text) ?? 0,
      'queenBreed': _queenBreedController.text,
      'queenColor': _queenColorController.text,
      'notes': _notesController.text,
    });
  }

  @override
  void dispose() {
    _hiveNameController.dispose();
    _hiveTypeController.dispose();
    _hiveColorController.dispose();
    _locationController.dispose();
    _numberOfDeepsController.dispose();
    _numberOfSupersController.dispose();
    _numberOfFramesController.dispose();
    _queenBreedController.dispose();
    _queenColorController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
