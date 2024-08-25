import 'package:dravel/api/http_auth.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  late final FlutterSecureStorage _secureStorage;

  Rx<bool> isLogin = Rx(false);
  Rxn<String> userUid = Rxn(null);

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
      userUid.value = result['user'].uid;

      await _secureStorage.write(key: 'access', value: result['key'].accessKey);
      await _secureStorage.write(key: 'refresh', value: result['key'].refreshKey);
      await _secureStorage.write(key: 'uid', value: userUid.value);
    } else {
      isLogin.value = false;
    }
    return result != null ? result['key'] : null;
  }
}