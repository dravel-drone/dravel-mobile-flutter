import 'package:email_validator/email_validator.dart';

class InputValidator {
  static String? emailValidator(String? content) {
    if (content == null) return null;
    if (EmailValidator.validate(content)) return null;
    return '이메일이 유효하지 않습니다.';
  }
}