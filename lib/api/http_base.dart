import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HttpBase {
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  static const String baseUrl = 'https://fastapi-yolo-test.k1a2.xyz/';
  static const String domain = 'fastapi-yolo-test.k1a2.xyz';

  static Future<String?> getAccessKey() async {
    return await secureStorage.read(key: 'access');
  }
}