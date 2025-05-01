import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StylesPage extends StatefulWidget {
  final Function(List<Map<String, dynamic>>) onFavoriteSelected;

  StylesPage({required this.onFavoriteSelected});

  @override
  _StylesPageState createState() => _StylesPageState();
}

class _StylesPageState extends State<StylesPage> {
  String selectedFilter = "All";
  List<Map<String, dynamic>> favoriteItems = [];

  final List<Map<String, dynamic>> styles = [
    {
      "name": "Business Suit",
      "category": "Formal",
      "image": "assets/Bussiness_suit.jpg",
      "link": "https://www.zara.com/in/en/slim-fit-suit-blazer-p09722605.html"
    },
    {
      "name": "Casual T-Shirt",
      "category": "Informal",
      "image": "assets/oversized.jpg",
      "link": "https://www.flipkart.com/go-crazy-printed-men-round-neck-black-t-shirt/p/itmd44efe3440601"
    },
    {
      "name": "Office Blazer",
      "category": "Formal",
      "image": "assets/outfit3.jpg",
      "link": "https://www.amazon.in/TAHVO-Blazer-Fabric-Single-Breasted/dp/B0CW17RM84/"
    },
    {
      "name": "Jeans & Hoodie",
      "category": "Informal",
      "image": "assets/hoodie.jpg",
      "link": "https://www2.hm.com/en_in/productpage.1235414001.html"
    },
  ];

  void toggleFavorite(Map<String, dynamic> style) {
    setState(() {
      if (favoriteItems.contains(style)) {
        favoriteItems.remove(style);
      } else {
        favoriteItems.add(style);
      }
    });

    widget.onFavoriteSelected(favoriteItems);
  }

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    var filteredStyles = styles.where((item) => selectedFilter == "All" || item["category"] == selectedFilter).toList();

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
              _buildAppBar(context),
              _buildFilterOptions(),
              Expanded(
                child: _buildStylesGrid(filteredStyles),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            "Explore Styles",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 40), // For balance
        ],
      ),
    );
  }

  Widget _buildFilterOptions() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterButton("All"),
          _buildFilterButton("Formal"),
          _buildFilterButton("Informal"),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String filter) {
    bool isSelected = selectedFilter == filter;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = filter;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFB8500) : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Color(0xFFFB8500).withOpacity(0.5),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ] : [],
        ),
        child: Text(
          filter,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildStylesGrid(List<Map<String, dynamic>> filteredStyles) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: filteredStyles.length,
        itemBuilder: (context, index) {
          return _buildStyleCard(filteredStyles[index]);
        },
      ),
    );
  }

  Widget _buildStyleCard(Map<String, dynamic> style) {
    bool isLiked = favoriteItems.contains(style);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Image with tap handler
            GestureDetector(
              onTap: () => _launchURL(style["link"]),
              child: Image.asset(
                style["image"],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  stops: [0.6, 1.0],
                ),
              ),
            ),
            // Item name and like button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        style["name"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => toggleFavorite(style),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isLiked ? Color(0xFFFB8500) : Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Shop button
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: () => _launchURL(style["link"]),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFFFB8500),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shopping_cart, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "Shop",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}