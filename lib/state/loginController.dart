import 'dart:convert';
import 'package:flutter/material.dart' show TextEditingController;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:product_listing/core/routes/app_router.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login(String username, String password) async {
    isLoading.value = true;

    final url = Uri.parse("https://fakestoreapi.com/auth/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username.trim(),
          "password": password.trim(),
        }),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200||response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print("TOKEN: ${data["token"]}");

        Get.snackbar("Success", "Login Successful");
        Get.offNamed(AppRouter.productList);
      } else {
        Get.snackbar("Login Failed", "Invalid username or password");
      }
    } catch (e) {
      print("EXCEPTION: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
