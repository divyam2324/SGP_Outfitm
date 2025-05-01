import 'package:flutter/material.dart';

class TonePopup extends StatefulWidget {
  final List<String> imagePaths;

  TonePopup({required this.imagePaths});

  @override
  _TonePopupState createState() => _TonePopupState();
}

class _TonePopupState extends State<TonePopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 0;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _flipImage(bool isNext) {
    _controller.forward(from: 0).then((_) {
      setState(() {
        _isFlipped = !_isFlipped;
        if (isNext) {
          _currentIndex =
              (_currentIndex + 1) % widget.imagePaths.length;
        } else {
          _currentIndex = (_currentIndex - 1 + widget.imagePaths.length) %
              widget.imagePaths.length;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8ECAE6).withOpacity(0.95), // Light Blue
              Color(0xFF023047).withOpacity(0.95), // Deep Navy Blue
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Outfit Suggestion',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final rotate = _animation.value;
                final angle = rotate * 3.14;
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(angle),
                  child: Container(
                    width: 280,
                    height: 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        widget.imagePaths[_currentIndex],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNavigationButton(
                  Icons.arrow_back_ios,
                  () => _flipImage(false),
                  Color(0xFFFB8500), // Orange
                ),
                SizedBox(width: 30),
                _buildNavigationButton(
                  Icons.arrow_forward_ios,
                  () => _flipImage(true),
                  Color(0xFF219EBC), // Vibrant Blue
                ),
              ],
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onTap, Color bgColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}