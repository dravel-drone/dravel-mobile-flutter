import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rx<bool> isLogin = Rx(false);

  Future<bool> checkLogin() async {
    return false;
  }
}