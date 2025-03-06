import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;
  double get totalPrice => _cartItems.fold(0, (sum, item) => sum + item.price);

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  Future<bool> purchaseItems() async {
    final url = Uri.parse('http://localhost:5001/purchase');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "cartItems": _cartItems
              .map((product) => {
                    "id": product.id,
                    "name": product.name,
                    "price": product.price
                  })
              .toList(),
          "totalAmount": totalPrice,
        }),
      );

      if (response.statusCode == 200) {
        _cartItems.clear();
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Hata: $e");
      return false;
    }
  }
}
