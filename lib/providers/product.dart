import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String token, String userId) async {
    var oldstatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final url =
        "https://my-cart-12ace.firebaseio.com/userFavorites/$userId/$id.json?auth=$token";
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        isFavorite = oldstatus;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldstatus;
      notifyListeners();
    }
  }
}
