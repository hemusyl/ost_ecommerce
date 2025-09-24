import 'package:get/get.dart';

import '../../core/models/network_response.dart';
import '../../core/services/network_caller.dart';
import '../../features/auth/data/models/login_request_model.dart';
import '../../features/shared/presentation/models/user_model.dart';
import '../utils/urls.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;
  String? _errorMessage;
  UserModel? _userModel;
  String? _accessToken;

  String? get errorMessage => _errorMessage;

  bool get logInProgress => _loginInProgress;

  UserModel? get userModel => _userModel;

  String? get accessToken => _accessToken;

  Future<bool> login(LoginRequestModel model) async {
    bool isSuccess = false;
    _loginInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.loginUrl, body: model.toJson());

    if (response.isSuccess) {
      _errorMessage = null;
      _userModel = UserModel.fromJson(response.body!['data']['user']);
      _accessToken = response.body!['data']['token'];
      isSuccess = true;
    } else {
      _errorMessage = response.body?['msg'] ?? response.errorMessage;
    }
    _loginInProgress = false;
    update();

    return isSuccess;
  }
}