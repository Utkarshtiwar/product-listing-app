import 'package:flutter/material.dart';
import '../../data/model/product_model.dart';
import '../../state/cart_controller.dart';
import '../wigets/add_to_cart.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Product product =Get.arguments;
    final CartController cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(title: Text(product.title),
        actions: [
          Cart()
        ],
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF74EBD5), // Aqua tone
                Color(0xFFACB6E5), // Lavender tone
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.thumbnail),
            const SizedBox(height: 16),
            Text(product.title,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 8),
            Text("₹${product.price}",
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                cartController.addToCart(product);
              },
              icon: const Icon(Icons.add_shopping_cart,
                color: Colors.black,
              ),
              label: const Text("Add to Cart",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
