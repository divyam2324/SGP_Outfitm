import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'style.dart';
import 'wardrobe.dart';
import 'shop.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'select.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> outfitItems = [
    {
      'image': 'assets/outfit3.jpg',
      'name': 'Summer Casual',
      'description': 'Perfect for warm days',
    },
    {
      'image': 'assets/oversized.jpg',
      'name': 'Urban Streetwear',
      'description': 'Trendy and comfortable',
    },
    {
      'image': 'assets/Bussiness_suit.jpg',
      'name': 'Business Professional',
      'description': 'For formal occasions',
    },
  ];

  String username = "UserName"; // Change dynamically if needed
  List<Map<String, dynamic>> favoriteItems = []; // Store liked styles
  CarouselSliderController carouselController = CarouselSliderController();
  int _currentCarouselIndex = 0;

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
      // Navigate to Select Page (Upload)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SelectPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

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
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildAppBar()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGreeting(),
                      SizedBox(height: 30),
                      _buildOutfitCarousel(screenSize),
                      SizedBox(height: 16),
                      _buildCarouselIndicators(),
                      SizedBox(height: 30),
                      _buildSectionTitle("Quick Access"),
                      SizedBox(height: 16),
                      _buildQuickAccessButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Outfit Matcher",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Good Morning,",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: 4),
        Text(
          username,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12),
        Text(
          "Here's your outfit suggestion for today:",
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildOutfitCarousel(Size screenSize) {
    return CarouselSlider.builder(
      carouselController: carouselController,
      itemCount: outfitItems.length,
      options: CarouselOptions(
        height: screenSize.height * 0.45,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        viewportFraction: 0.85,
        onPageChanged: (index, reason) {
          setState(() {
            _currentCarouselIndex = index;
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final item = outfitItems[index];
        return _buildOutfitCard(item);
      },
    );
  }

  Widget _buildOutfitCard(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              item['image'],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                stops: [0.6, 1.0],
              ),
            ),
          ),
          // Content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item['description'],
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFFFB8500),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          "Try Now",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      IconButton(
                        icon: Icon(Icons.favorite_border, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          outfitItems.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => carouselController.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentCarouselIndex == entry.key
                          ? Color(0xFFFB8500)
                          : Colors.white.withOpacity(0.5),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "See All",
            style: TextStyle(
              color: Color(0xFFFFB703),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAccessButtons() {
    return Row(
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
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShopPage()),
          ),
          Color(0xFF219EBC), // Vibrant Blue
        ),
      ],
    );
  }

  Widget _buildQuickAccessButton(
    IconData icon,
    String label,
    VoidCallback onTap,
    Color bgColor,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: bgColor.withOpacity(0.5),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          SizedBox(height: 8),
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

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF023047),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF023047),
          selectedItemColor: Color(0xFFFB8500),
          unselectedItemColor: Colors.white60,
          showUnselectedLabels: true,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_photo_alternate_rounded),
              label: "Upload",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToWardrobe(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WardrobePage(favoriteItems: favoriteItems),
      ),
    );
  }

  void _navigateToStyles(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StylesPage(onFavoriteSelected: updateWardrobe),
      ),
    );
  }
}