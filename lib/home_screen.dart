import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'style.dart';
import 'wardrobe.dart';
import 'shop.dart';
import 'profile_screen.dart'; // Import Profile Page
import 'settings_screen.dart'; // Import Settings Page

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> outfitImages = [
    'assets/outfit3.jpg',
    'assets/oversized.jpg',
    'assets/Bussiness_suit.jpg',
  ];

  String username = "UserName"; // Change dynamically if needed
  List<Map<String, dynamic>> favoriteItems = []; // Store liked styles

  void updateWardrobe(List<Map<String, dynamic>> newFavorites) {
    setState(() {
      favoriteItems = newFavorites;
    });
  }

  int _selectedIndex = 0; // For bottom navigation

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Navigate to Profile Page (Edit Profile)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } else if (index == 2) {
      // Navigate to Settings Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
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
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  title: Text(
                    "Outfit Matcher",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                SizedBox(height: 10),
                Text(
                  "Good Morning, $username!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Here’s your outfit suggestion for today:",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 20),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 320,
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                  items: outfitImages.map((imagePath) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildQuickAccessButton(
                      Icons.shopping_bag,
                      "Wardrobe",
                          () => _navigateToWardrobe(context),
                      Color(0xFFFB8500), // Orange
                    ),
                    _buildQuickAccessButton(
                      Icons.style,
                      "Styles",
                          () => _navigateToStyles(context),
                      Color(0xFFFFB703), // Golden Yellow
                    ),
                    _buildQuickAccessButton(
                      Icons.shopping_cart,
                      "Shop",
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => ShopPage())),
                      Color(0xFF219EBC), // Vibrant Blue
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Use the function
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF023047), // Deep Navy for contrast
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }

  Widget _buildQuickAccessButton(IconData icon, String label, VoidCallback onTap, Color bgColor) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: bgColor,
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToWardrobe(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WardrobePage(favoriteItems: favoriteItems)),
    );
  }

  void _navigateToStyles(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StylesPage(onFavoriteSelected: updateWardrobe)),
    );
  }
}
