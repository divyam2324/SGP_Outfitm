import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _favoriteItems = [];

  List<Map<String, dynamic>> get favoriteItems => _favoriteItems;

  void toggleFavorite(Map<String, dynamic> style) {
    bool alreadyLiked = _favoriteItems.any((item) => item["name"] == style["name"]);

    if (alreadyLiked) {
      _favoriteItems.removeWhere((item) => item["name"] == style["name"]);
    } else {
      _favoriteItems.add(style);
    }

    notifyListeners(); // Notifies UI to update
  }
}
