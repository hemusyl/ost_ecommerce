import 'package:get/get.dart';

import '../../../../app/utils/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
class AddToCartController extends GetxController {
  bool _addToCartInProgress = false;

  String? _errorMessage;

  bool get addToCartInProgress => _addToCartInProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> addToCart(String productId) async {
    bool isSuccess = false;
    _addToCartInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.addToCartUrl, body: {'product': productId});
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _addToCartInProgress = false;
    update();

    return isSuccess;
  }
}