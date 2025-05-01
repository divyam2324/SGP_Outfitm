import 'package:flutter/material.dart';
import 'package:sgp/editprofile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Divyam Lavri"; // Example User Data
  String email = "divyam.lavri@example.com";
  String gender = "Male";
  String age = "21";
  String skinTone = "Medium"; // Can be used in Outfit Matching logic

  void _editProfile() async {
    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          name: name,
          email: email,
          gender: gender,
          age: age,
          skinTone: skinTone,
        ),
      ),
    );

    if (updatedUser != null) {
      setState(() {
        name = updatedUser["name"];
        email = updatedUser["email"];
        gender = updatedUser["gender"];
        age = updatedUser["age"];
        skinTone = updatedUser["skinTone"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editProfile, // Navigate to Edit Profile Screen
          ),
        ],
        backgroundColor: Color(0xFF023047),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFFB8500),
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            _buildProfileInfo("Name", name),
            _buildProfileInfo("Email", email),
            _buildProfileInfo("Gender", gender),
            _buildProfileInfo("Age", age),
            _buildProfileInfo("Skin Tone", skinTone),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
