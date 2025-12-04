import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchControllerOst extends GetxController {
  var isLoading = false.obs;
  var searchResults = <dynamic>[].obs;

  // <- Make sure this method exists exactly like this:
  Future<void> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isLoading.value = true;
      final url = Uri.parse("https://ecom-rs8e.onrender.com/api/products?search=${Uri.encodeComponent(query)}");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // adjust the key if your API returns something different
        searchResults.value = data['products'] ?? [];
      } else {
        searchResults.clear();
      }
    } catch (e) {
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
