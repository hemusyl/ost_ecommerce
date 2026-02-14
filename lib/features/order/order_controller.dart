import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ost_ecommerce/features/order/shipping_address_model.dart';

import '../../app/utils/urls.dart';
import '../../core/models/network_response.dart';
import '../../core/services/network_caller.dart';
import '../payments/sslcommerz.dart';
import 'create_order_request_model.dart';
import 'order_model.dart';

class OrderController extends GetxController {
  bool _inProgress = false;
  bool _paymentInProgress = false;
  OrderModel? _orderModel;
  String? _errorMessage;
  Map<String, dynamic>? _paymentResult;

  bool get inProgress => _inProgress;
  bool get paymentInProgress => _paymentInProgress;
  OrderModel? get orderModel => _orderModel;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get paymentResult => _paymentResult;

  Future<bool> createOrder({
    required String fullName,
    required String address,
    required String city,
    required String postalCode,
    required String phone,
  }) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final shippingAddress = ShippingAddressModel(
      fullName: fullName,
      address: address,
      city: city,
      postalCode: postalCode,
      phone: phone,
    );

    final orderRequest = CreateOrderRequestModel(
      paymentMethod: 'ssl',
      shippingAddress: shippingAddress,
      redirectUrl: 'https://jsonplaceholder.typicode.com/posts',
    );

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.createOrderUrl, body: orderRequest.toJson());

    if (response.isSuccess) {
      _orderModel = OrderModel.fromJson(response.body!['data']);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }

  Future<bool> processPayment({required int totalAmount}) async {
    bool isSuccess = false;
    _paymentInProgress = true;
    _errorMessage = null;
    update();

    try {
      final String tranId = DateTime.now().millisecondsSinceEpoch.toString();

      final Map<String, dynamic> paymentResult =
      await SSLPaymentHelper.processPayment(
        totalAmount: totalAmount,
        tranId: tranId,
      );

      _paymentResult = paymentResult;

      if (paymentResult['success'] == true) {
        _errorMessage = null;
        isSuccess = true;
      } else {
        _errorMessage = paymentResult['message'] ?? 'Payment failed';
      }
    } catch (e) {
      _errorMessage = 'Payment processing failed: $e';
      print('Order Controller Payment Error: $e');
    }

    _paymentInProgress = false;
    update();

    return isSuccess;
  }

  Future<bool> createOrderWithPayment({
    required String fullName,
    required String address,
    required String city,
    required String postalCode,
    required String phone,
    required int totalAmount,
  }) async {
    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final bool orderCreated = await createOrder(
      fullName: fullName,
      address: address,
      city: city,
      postalCode: postalCode,
      phone: phone,
    );

    if (orderCreated) {
      final bool paymentSuccess = await processPayment(
        totalAmount: totalAmount,
      );
      isSuccess = paymentSuccess;
    } else {
      _errorMessage = 'Failed to create order';
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}