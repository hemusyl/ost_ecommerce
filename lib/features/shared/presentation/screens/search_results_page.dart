import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ost_ecommerce/app/controllers/search_controller_ah.dart';

class SearchResultsPage extends StatelessWidget {
  final String query;
  SearchResultsPage({required this.query});

  final ProductSearchController controller = Get.put(ProductSearchController());


  @override
  Widget build(BuildContext context) {
    controller.searchProducts(query);

    return Scaffold(
      appBar: AppBar(
        title: Text("Results for \"$query\""),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.products.isEmpty) {
          return Center(child: Text("No products found"));
        }

        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (_, index) {
            final p = controller.products[index];
            return ListTile(
              leading: Image.network(
                p["images"][0] ?? "",
                width: 60,
                fit: BoxFit.cover,
              ),
              title: Text(p["name"] ?? ""),
              subtitle: Text("₹${p["price"]}"),
              onTap: () {
                // Navigate to product details if needed
              },
            );
          },
        );
      }),
    );
  }
}
