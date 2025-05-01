import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'color_pair.dart';

class SelectPage extends StatefulWidget {
  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  final Map<Color, String> toneToSubject = {
    Color(0xFF3A0D2D): 'subject12',
    Color(0xFF333333): 'subject12',
    Color(0xFF000000): 'subject12',
    Color(0xFF1B3F2E): 'subject12',
  };

  final List<Color> tones = [
    Color(0xFF7A4A28), // Dark Brown
    Color(0xFFB3713D), // Warm Bronze
    Color(0xFFD4A980), // Tan
    Color(0xFFE8D3C0), // Light Beige
    Color(0xFFF6DDCC), // Fair / Pale Peach
  ];

  void _onToneSelected(Color tone) {
    final subjectKey = toneToSubject[tone] ?? 'subject8'; // fallback subject
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ColorPairsPage(subjectKey: subjectKey),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));

      // For now, navigate to hardcoded subject
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ColorPairsPage(subjectKey: 'subject8'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8ECAE6), // Light Blue
              Color(0xFF023047), // Deep Navy Blue
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      _buildToneSelector(),
                      SizedBox(height: 25),
                      Divider(thickness: 1.2, color: Colors.white30),
                      SizedBox(height: 25),
                      _buildUploadBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Center(
              child: Text(
                'OUTFIT MATCHER',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 48), // spacer
        ],
      ),
    );
  }

  Widget _buildToneSelector() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Select your skin tone',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tones.map((color) {
              return GestureDetector(
                onTap: () => _onToneSelected(color),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadBox() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Upload your photo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15),
          Divider(thickness: 1.0, color: Colors.white30),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildUploadButton(
                Icons.image,
                "Gallery",
                () => _pickImage(ImageSource.gallery),
                Color(0xFFFB8500), // Orange
              ),
              _buildUploadButton(
                Icons.upload,
                "Upload",
                () => _pickImage(ImageSource.gallery),
                Color(0xFFFFB703), // Golden Yellow
              ),
              _buildUploadButton(
                Icons.camera_alt,
                "Camera",
                () => _pickImage(ImageSource.camera),
                Color(0xFF219EBC), // Vibrant Blue
              ),
            ],
          ),
          SizedBox(height: 20),
          if (_selectedImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                _selectedImage!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUploadButton(IconData icon, String label, VoidCallback onTap, Color bgColor) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: bgColor,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}