import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/CartProvider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Sepetiniz")),
      body: cartProvider.cartItems.isEmpty
          ? Center(child: Text("Sepetiniz boş"))
          : ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final product = cartProvider.cartItems[index];
                return Card(
                  child: ListTile(
                    leading:
                        Image.network(product.imageUrl, width: 50, height: 50),
                    title: Text(product.name),
                    subtitle: Text("${product.price} TL"),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_shopping_cart),
                      onPressed: () => cartProvider.removeFromCart(product),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Text("Toplam: ${cartProvider.totalPrice} TL",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
