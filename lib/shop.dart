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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Shop"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildShopIcon("Amazon", "assets/amazon-icon.png", "https://www.amazon.in/"),
            _buildShopIcon("Flipkart", "assets/flipkart_logo.png", "https://www.flipkart.com"),
            _buildShopIcon("Myntra", "assets/myntra_logo.png", "https://www.myntra.com"),
            _buildShopIcon("Zara", "assets/zara_logo.png", "https://www.zara.com"),
            _buildShopIcon("H&M", "assets/hm_logo.png", "https://www2.hm.com"),
            
          ],
        ),
      ),
    );
  }

  /// **🔹 Circular Button for Shops**
  Widget _buildShopIcon(String name, String imagePath, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// **Circular Logo Container**
          Container(
            width: 80, // Adjust size
            height: 80, // Adjust size
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // Background color
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Padding(
                padding: EdgeInsets.all(10), // Adjust padding to fit the image
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
