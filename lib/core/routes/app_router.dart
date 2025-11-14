import 'package:get/get.dart';
import '../../data/model/product_model.dart';
import '../../presentation/screen/Cart_screen.dart';
import '../../presentation/screen/login_screen.dart';
import '../../presentation/screen/product_detail_screen.dart';
import '../../presentation/screen/product_list_screen.dart';
class AppRouter {
  static const String productList = '/';
  static const String productDetail = '/detail';
  static const String cart = '/cart';
  static const String splash = '/splash';
  static const String login = '/login';

  static final routes = [
    GetPage(
      name: productList,
      page: () => const ProductListScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 500)
    ),
    GetPage(   
      name: productDetail,
      page: () {
        final product = Get.arguments as Product;
        return ProductDetailScreen(product: product);

      },
        transition: Transition.rightToLeftWithFade,
        transitionDuration: Duration(milliseconds: 500)
    ),
    GetPage(
        name: cart,
        page: () => CartScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: login,
      page: () => LoginScreen(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 350)
    )
  ];
}
