import 'package:get/get.dart';

import '../../../app/utils/urls.dart';
import '../../../core/models/network_response.dart';
import '../../../core/services/network_caller.dart';
import '../data/models/cart_item_model.dart';

class CartListController extends GetxController {
  bool _inProgress = false;

  List<CartItemModel> _cartItemList = [];

  bool get inProgress => _inProgress;

  List<CartItemModel> get cartItemList => _cartItemList;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.cartListUrl,
    );
    if (response.isSuccess) {
      List<CartItemModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']['results']) {
        list.add(CartItemModel.fromJson(jsonData));
      }
      _cartItemList = list;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }


  Future<bool> removeCart(dynamic cartItemId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    try {
      // Example: your API may expect DELETE /cart/{id} or POST with id in body.
      // Replace with the appropriate NetworkCaller method & Url.
      final NetworkResponse response = await Get.find<NetworkCaller>().deleteRequest(
        url: Urls.cartDeleteUrl(cartItemId), // adjust to your endpoint
        body: {'id': cartItemId}, // adjust payload if needed
      );

      if (response.isSuccess) {
        // remove locally
        _cartItemList.removeWhere((item) => item.id == cartItemId);
        isSuccess = true;
      } else {
        // server returned error
        isSuccess = false;
        // Optionally keep _errorMessage
        _errorMessage = response.errorMessage;
      }
    } catch (e) {
      _errorMessage = e.toString();
      isSuccess = false;
    } finally {
      _inProgress = false;
      update();
    }

    return isSuccess;
  }





  int get totalPrice {
    int total = 0;
    for (CartItemModel item in _cartItemList) {
      total += (item.quantity * item.product.currentPrice);
    }

    return total;
  }

  void updateCart(String cartItemId, int quantity) {
    _cartItemList.firstWhere((item) => item.id == cartItemId)
        .quantity = quantity;
    update();
  }

}