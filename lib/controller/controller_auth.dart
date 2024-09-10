import 'package:dravel/api/http_auth.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:dravel/pages/account/page_login.dart';
import 'package:flutter/material.dart';
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
    bool isLogin = await _secureStorage.read(key: 'access') != null
        && await _secureStorage.read(key: 'refresh') != null
        && await _secureStorage.read(key: 'uid') != null;

    if (isLogin) userUid.value = await _secureStorage.read(key: 'uid');

    return isLogin;
  }

  Future<AuthKeyModel?> login({
    required String id,
    required String password
  }) async {
    Map<String, dynamic>? result = await AuthHttp.login(
      LoginModel(
        id: id,
        password: password,
        deviceId: (await _secureStorage.read(key: 'device_id'))!
      )
    );
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

  Future<void> logout() async {
    Get.dialog(
      const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 12,),
            Text('로그아웃중..')
          ],
        ),
        buttonPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.fromLTRB(18, 24, 18, 24),
      ),
      barrierDismissible: false
    );

    bool result = false;
    if (userUid.value != null) {
      result = await AuthHttp.logout(
          LogoutModel(
              deviceId: (await _secureStorage.read(key: 'device_id'))!,
              uid: userUid.value!
          )
      );
    }

    await _secureStorage.delete(key: 'access');
    await _secureStorage.delete(key: 'refresh');
    await _secureStorage.delete(key: 'uid');
    Get.offAll(() => LoginPage());

    if (!result) {
      Get.showSnackbar(
          const GetSnackBar(
            message: "로그아웃 오류",
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
          )
      );
    }
  }

  Future<bool> refreshAccessToken() async {
    String? refreshToken = await _secureStorage.read(key: 'refresh');
    if (refreshToken == null) {
      logout();
      return false;
    }

    String? result = await AuthHttp.refresh(
      RefreshModel(deviceId: (await _secureStorage.read(key: 'device_id'))!),
      refreshToken: refreshToken
    );
    if (result == null) {
      logout();
      return false;
    }
    await _secureStorage.write(key: 'access', value: result);
    return true;
  }
}