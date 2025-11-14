import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/model/product_model.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  var total = 0.0.obs;
  var isLoading = true.obs;

  void addToCart(Product product) {
    if (!cartItems.contains(product)) {
      cartItems.add(product);
      total.value += product.price;
      update();
      Get.snackbar(
        'Product Added',
        'You have successfully added a product',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
    } else {
      Get.snackbar(
        'Product Already Added',
        'You have already added this product',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
    }
  }

  void clearCart() {
    cartItems.clear();
    total.value = 0.0;
    update();
  }


  void removeFromCart(Product product) {
    cartItems.remove(product);
    total.value -= product.price;
    update();
  }
  double get totalPrice =>cartItems.fold(0,(sum,item) => sum + item.price);
}
