import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductSearchController extends GetxController {
  var isLoading = false.obs;
  var products = [].obs;

  Future<void> searchProducts(String query) async {
    try {
      isLoading(true);

      final url = Uri.parse("https://ecom-rs8e.onrender.com/api/products?search=$query");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        products.value = data["products"] ?? [];
      } else {
        products.clear();
      }
    } finally {
      isLoading(false);
    }
  }
}

