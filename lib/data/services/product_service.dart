import 'package:dio/dio.dart';
import '../model/product_model.dart';
import '../../core/constants/api_endpoints.dart';

class ProductService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get(ApiEndpoints.products);
      List products = response.data['products'];
      return products.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to load products: $e");
    }
  }
}
