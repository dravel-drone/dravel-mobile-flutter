import 'package:dravel/api/http_auth.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  late final FlutterSecureStorage _secureStorage;

  Rx<bool> isLogin = Rx(false);
  Rxn<LoginUserModel> loginUser = Rxn(null);

  @override
  void onInit() {
    _secureStorage = FlutterSecureStorage();
    super.onInit();
  }

  Future<bool> checkLogin() async {
    return await _secureStorage.read(key: 'access') != null
        && await _secureStorage.read(key: 'refresh') != null;
  }

  Future<AuthKeyModel?> login(LoginModel loginModel) async {
    Map<String, dynamic>? result = await AuthHttp.login(loginModel);
    if (result != null) {
      isLogin.value = true;
      loginUser.value = result['user'];
    } else {
      isLogin.value = false;
    }
    return result != null ? result['key'] : null;
  }
}