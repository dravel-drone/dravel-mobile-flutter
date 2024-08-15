import 'package:dravel/api/http_base.dart';
import 'package:dravel/model/model_auth.dart';
import 'package:http/http.dart' as http;

class AuthHttp {
  static Future<bool> registerUser(RegisterModel inputModel) async {
    final url = Uri.https(HttpBase.domain, 'api/v1/term');
    final response = await http.post(url, body: inputModel.toJson());
    if (response.statusCode != 200) return false;
    return true;
  }
}
