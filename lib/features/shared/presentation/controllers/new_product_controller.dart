import 'package:get/get.dart';

import '../../../../app/utils/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';


class NewProductController extends GetxController {
  int _currentPage = 0;

  int? _lastPageNo;

  final int _pageSize = 40;

  bool _getNewProductInProgress = false;

  bool _isInitialLoading = false;

  final List<ProductModel> _NewProductList = [];



  String? _errorMessage;

  bool get getProductsInProgress  => _getNewProductInProgress;

  bool get isInitialLoading => _isInitialLoading;

  List<ProductModel> get NewProductList => _NewProductList;

  String? get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
    getNewProductList();
  }

  Future<bool> getNewProductList() async {
    bool isSuccess = false;

    if (_currentPage > (_lastPageNo ?? 1)) {
      return false;
    }
    if (_currentPage == 0) {
      _NewProductList.clear();
      _isInitialLoading = true;
    } else {
      _getNewProductInProgress = true;
    }
    update();

    _currentPage++;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        url: Urls.newProducts(_currentPage, _pageSize));



    if (response.isSuccess) {
      _lastPageNo = response.body!['data']['last_page'];
      List<ProductModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']['results']) {
        list.add(ProductModel.fromJson(jsonData));
      }
      _NewProductList.addAll(list);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (_isInitialLoading) {
      _isInitialLoading = false;
    } else {
      _getNewProductInProgress = false;
    }

    update();
    return isSuccess;
  }

  Future<void> refreshCategoryList() async {
    _currentPage = 0;
    getNewProductList();
  }
}