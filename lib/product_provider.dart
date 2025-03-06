import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    final url = Uri.parse('https://fakestoreapi.com/products');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        _products = data
            .map((item) => Product(
                  id: item['id'].toString(),
                  name: item['title'],
                  price: item['price'].toDouble(),
                  imageUrl: item['image'],
                ))
            .toList();

        notifyListeners();
      } else {
        throw Exception('Veri alınamadı!');
      }
    } catch (e) {
      print("Hata: $e");
    }
  }
}
