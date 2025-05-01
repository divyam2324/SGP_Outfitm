import 'package:flutter/material.dart';
import 'tone_popup.dart';

class ColorPairsPage extends StatelessWidget {
  final String subjectKey;

  ColorPairsPage({required this.subjectKey});

  final List<Map<String, dynamic>> subject8Pairs = [
    {
      "colors": [Color.fromARGB(255, 39, 194, 160), Color.fromARGB(255, 174, 147, 103)], // Mustard + Coral
      "images": ["assets/ps1.jpg", "assets/pp1.jpg"]
    },
    {
      "colors": [Color.fromARGB(255, 202, 51, 116), Color.fromARGB(255, 226, 226, 226)], // Mustard + Turquoise
      "images": ["assets/ps2.jpg", "assets/pp2.jpg"]
    },
    {
      "colors": [Color.fromARGB(255, 29, 26, 26), Color.fromARGB(255, 149, 152, 155)], // Coral + Tangerine
      "images": ["assets/ps3.jpg", "assets/pp3.jpg"]
    },
    {
      "colors": [Color.fromARGB(255, 12, 47, 142), Color.fromARGB(255, 255, 255, 255)], // Turquoise + Tangerine
      "images": ["assets/ps4.jpg", "assets/pp4.jpg"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> colorPairs = [];

    if (subjectKey == 'subject8') {
      colorPairs = subject8Pairs;
    }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text(
                  "Recommended Color Combinations",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Text(
                  "Tap on any combination to see outfit examples",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: colorPairs.length,
                  itemBuilder: (context, index) {
                    final pair = colorPairs[index];
                    final colors = pair['colors'] as List<Color>;
                    final images = pair['images'] as List<String>;

                    return _buildColorPairCard(context, colors, images, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                'COLOR PAIRS',
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

  Widget _buildColorPairCard(BuildContext context, List<Color> colors, List<String> images, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => TonePopup(imagePaths: images),
          );
        },
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [colors[0], colors[1]],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: colors[0].withOpacity(0.5),
                blurRadius: 8,
                offset: Offset(-2, 4),
              ),
              BoxShadow(
                color: colors[1].withOpacity(0.5),
                blurRadius: 8,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Pair ${index + 1}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: colors.map((color) {
                    return Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Icon(
                  Icons.visibility,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}