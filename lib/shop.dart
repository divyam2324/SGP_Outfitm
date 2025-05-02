import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopPage extends StatelessWidget {
  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  final List<Map<String, dynamic>> shops = [
    {
      'name': 'Amazon',
      'image': 'assets/amazon-icon.png',
      'url': 'https://www.amazon.in/',
      'color': Color(0xFF232F3E), // Amazon's navy blue color
    },
    {
      'name': 'Flipkart',
      'image': 'assets/flipkart_logo.png',
      'url': 'https://www.flipkart.com',
      'color': Color(0xFF2874F0), // Flipkart blue
    },
    {
      'name': 'Myntra',
      'image': 'assets/myntra_logo.png',
      'url': 'https://www.myntra.com',
      'color': Color(0xFFE91E63), // Myntra pink
    },
    {
      'name': 'Zara',
      'image': 'assets/zara_logo.png',
      'url': 'https://www.zara.com',
      'color': Color(0xFF000000), // Black for Zara
    },
    {
      'name': 'H&M',
      'image': 'assets/hm_logo.png',
      'url': 'https://www2.hm.com',
      'color': Color(0xFFE50010), // H&M red
    },
    {
      'name': 'AJIO',
      'image': 'assets/ajio.jpg', // Replace with actual AJIO logo
      'url': 'https://www.ajio.com',
      'color': Color(0xFF2979FF), // Blue color for AJIO
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8ECAE6), // Light Blue - matching home screen
              Color(0xFF023047), // Deep Navy Blue - matching home screen
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Shop your favorite styles from these top retailers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: shops.length,
                    itemBuilder: (context, index) {
                      return _buildShopCard(
                        shops[index]['name'],
                        shops[index]['image'],
                        shops[index]['url'],
                        shops[index]['color'],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(width: 8),
          Text(
            "Shop",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              // Show info dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("About Shopping"),
                    content: Text(
                      "These links will take you to external shopping sites where you can purchase items similar to those recommended in the app.",
                    ),
                    actions: [
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShopCard(String name, String imagePath, String url, Color color) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Shop logo
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
                border: Border.all(
                  color: color.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              ),
            ),
            SizedBox(height: 12),
            // Shop name
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 8),
            // Visit button
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Visit Store",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}