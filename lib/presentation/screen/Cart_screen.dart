import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/product_model.dart';
import '../../state/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart'),
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
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(child: Text('No items in the cart'));
        }
        return ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (_, int index) {
            Product product = cartController.cartItems[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Image.network(product.thumbnail, width: 60),
                title: Text(product.title),
                subtitle: Text('₹${product.price}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    cartController.removeFromCart(product);
                  },
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Text(
            'Total: ₹${cartController.totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
