import 'package:get/get.dart';
import '../data/model/product_model.dart';
import '../data/services/product_service.dart';

class ProductController extends GetxController {
  final ProductService _service = ProductService();

  var products = <Product>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isGridView = true.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      errorMessage('');
      products.value = await _service.fetchProducts();
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void toggleView() => isGridView.toggle();

  List<Product> get filteredProducts {
    if (searchQuery.isEmpty) return products;
    return products
        .where((p) =>
        p.title.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }
}
