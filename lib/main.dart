import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_listing/state/cart_controller.dart';
import 'package:product_listing/state/product_controller.dart';
import 'core/routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(CartController());
  Get.put(ProductController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Listing App',
      theme: ThemeData(primarySwatch: Colors.teal),
      getPages: AppRouter.routes,
      initialRoute: AppRouter.splash,

      // FIXED → snackbar overlay
      builder: (context, child) => Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) => child!,
          )
        ],
      ),
    );
  }
}
