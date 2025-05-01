import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

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
      "link": "https://www.amazon.in/TAHVO-Blazer-Fabric-Single-Breasted/dp/B0CW17RM84/ref=sr_1_2?dib=eyJ2IjoiMSJ9.-J5RAM6obGouS-y2tI-A2YnNrKdTDhFAY452m4VQOsCYNoPzwfMQOu_lSUfiIEkqFWwMm3hHsBxlR_FNKZ83a7zsCj_EBMWvOMOYSdHbvc0ILuZ-rUwnZOm19pQ7xM6GQLpUSW3UW-xZMFs4sVUzT_N2MAHIguLNoFldTeJ-zSVqWBC4WZmmCZPM-0gGnu30yU2Fn7GrWcg4KVq6t8VtqGceoHvDzq0Y5ENpTPlvafaSaFgEBt9NNDYcwiOxDmCQ6xuTXFlffXHk0gkh6mlpU8FhSsy2kvZKaWurGozNgMc._frUdusgLHD9N3wDmkiVGM45n3KXU49RRyE3aKLGpEo&dib_tag=se&keywords=grey%2Bblazer%2Bfor%2Bmen&qid=1743615193&sr=8-2&th=1&psc=1"
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Styles"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton("All"),
                _buildFilterButton("Formal"),
                _buildFilterButton("Informal"),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: filteredStyles.length,
              itemBuilder: (context, index) {
                return _buildStyleCard(filteredStyles[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String filter) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedFilter = filter;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedFilter == filter ? Colors.black : Colors.grey[300],
        foregroundColor: selectedFilter == filter ? Colors.white : Colors.black,
      ),
      child: Text(filter),
    );
  }

  Widget _buildStyleCard(Map<String, dynamic> style) {
    bool isLiked = favoriteItems.contains(style);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _launchURL(style["link"]), // Open link when tapped
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(style["image"], fit: BoxFit.cover, width: double.infinity),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  style["name"],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.grey),
                  onPressed: () {
                    toggleFavorite(style);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
