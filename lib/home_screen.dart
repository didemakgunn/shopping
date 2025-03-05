import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/CartProvider.dart';
import 'package:shopping/cart_screen.dart';
import 'product.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Laptop',
      price: 54700,
      imageUrl:
          'https://productimages.hepsiburada.net/s/429/848-1200/110000460992834.jpg/format:webp',
    ),
    Product(
      id: '2',
      name: 'Telefon',
      price: 37899,
      imageUrl:
          'https://productimages.hepsiburada.net/s/337/424-600/110000278035368.jpg/format:webp',
    ),
    Product(
      id: '3',
      name: 'Kulaklık',
      price: 1350,
      imageUrl:
          'https://productimages.hepsiburada.net/s/448/848-1200/110000482594638.jpg/format:webp',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Text(
                    cartProvider.cartItems.length.toString(),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              leading: Image.network(product.imageUrl, width: 50, height: 50),
              title: Text(product.name),
              subtitle: Text("${product.price} TL"),
              trailing: IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () => cartProvider.addToCart(product),
              ),
            ),
          );
        },
      ),
    );
  }
}
