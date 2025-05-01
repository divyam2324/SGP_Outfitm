import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String gender;
  final String age;
  final String skinTone;

  EditProfileScreen({
    required this.name,
    required this.email,
    required this.gender,
    required this.age,
    required this.skinTone,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _ageController;
  String _selectedGender = "Male";
  String _selectedSkinTone = "Medium";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _ageController = TextEditingController(text: widget.age);
    _selectedGender = widget.gender;
    _selectedSkinTone = widget.skinTone;
  }

  void _saveChanges() {
    Navigator.pop(context, {
      "name": _nameController.text,
      "email": _emailController.text,
      "gender": _selectedGender,
      "age": _ageController.text,
      "skinTone": _selectedSkinTone,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Color(0xFF023047),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: "Age", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              items: ["Male", "Female", "Other"]
                  .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedGender = value!),
              decoration: InputDecoration(labelText: "Gender", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedSkinTone,
              items: ["Light", "Medium", "Dark"]
                  .map((tone) => DropdownMenuItem(value: tone, child: Text(tone)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedSkinTone = value!),
              decoration: InputDecoration(labelText: "Skin Tone", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFB8500),
                minimumSize: Size(double.infinity, 45),
              ),
              child: Text("Save Changes", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
