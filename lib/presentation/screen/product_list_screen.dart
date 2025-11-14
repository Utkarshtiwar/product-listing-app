import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../state/product_controller.dart';
import '../../../core/routes/app_router.dart';
import '../wigets/add_to_cart.dart';
import '../wigets/product_card.dart';
import '../wigets/search_bar.dart';
import '../wigets/shimmer_loading.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Discover Products",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
        actions: const [
          Cart(),
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return ShimmerLoading(isGrid: controller.isGridView.value);
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        final products = controller.filteredProducts;

        return RefreshIndicator(
          color: Colors.blueAccent,
          onRefresh: controller.fetchProducts,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: SearchBarWidget(
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                  },
                ),
              ),

              // Product list/grid
              Expanded(
                child: controller.isGridView.value
                    ? GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        AppRouter.productDetail,
                        arguments: product,
                      ),
                      child: Hero(
                        tag: product.id ?? index,
                        child: ProductCard(product: product),
                      ),
                    );
                  },
                )
                    : ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: products.length,
                  separatorBuilder: (_, __) =>
                  const Divider(height: 8, color: Colors.transparent),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  itemBuilder: (_, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        AppRouter.productDetail,
                        arguments: product,
                      ),
                      child: ProductCard(product: product),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
