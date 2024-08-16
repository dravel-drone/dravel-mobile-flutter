import 'package:dravel/api/http_auth.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rx<bool> isLogin = Rx(false);

  Future<bool> checkLogin() async {
    return false;
  }

  Future<bool> login(LoginModel loginModel) async {
    bool result = await AuthHttp.login(loginModel);
    isLogin.value = result;
    return result;
  }
}