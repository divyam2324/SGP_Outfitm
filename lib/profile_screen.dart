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
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        _buildProfileAvatar(),
                        SizedBox(height: 30),
                        _buildProfileCard(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Profile",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: _editProfile,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 65,
        backgroundColor: Color(0xFFFB8500),
        child: CircleAvatar(
          radius: 62,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            size: 80,
            color: Color(0xFFFB8500),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildProfileInfo("Name", name),
          Divider(height: 30, thickness: 1),
          _buildProfileInfo("Email", email),
          Divider(height: 30, thickness: 1),
          _buildProfileInfo("Gender", gender),
          Divider(height: 30, thickness: 1),
          _buildProfileInfo("Age", age),
          Divider(height: 30, thickness: 1),
          _buildProfileInfo("Skin Tone", skinTone),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF023047),
          ),
        ),
      ],
    );
  }
}