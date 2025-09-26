import 'package:get/get.dart';

import '../../../../app/utils/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../data/models/home_slider.dart';

class HomeSliderController extends GetxController {
  bool _getSlidersInProgress = false;
  String? _errorMessage;
  List<HomeSlider> _sliders = [];

  bool get getSlidersInProgress => _getSlidersInProgress;
  String? get errorMessage => _errorMessage;
  List<HomeSlider> get sliders => _sliders;

  Future<bool> getHomeSliders() async {
    bool isSuccess = false;
    _getSlidersInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        url: Urls.homeSlidersUrl);

    if (response.isSuccess) {
      _errorMessage = null;
      List<HomeSlider> listOfSliders = [];
      for (Map<String, dynamic> jsonData in response.body?['data']['results'] ?? []) {
        listOfSliders.add(HomeSlider.fromJson(jsonData));
      }
      _sliders = listOfSliders;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getSlidersInProgress = false;
    update();

    return isSuccess;
  }
}