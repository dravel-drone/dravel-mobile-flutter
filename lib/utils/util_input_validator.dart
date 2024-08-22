import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class InputValidator {
  static String? emailValidator(String? content) {
    if (content == null) return null;
    if (EmailValidator.validate(content)) return null;
    return '이메일이 유효하지 않습니다.';
  }

  static String? mustInputValidator(String? content) {
    if (content == null || content.isEmpty) return '필수입력 칸 입니다.';
    return null;
  }

  static String? passwordValidator(String? content) {
    final hasUpperCase = RegExp(r'[A-Z]');
    final hasLowerCase = RegExp(r'[a-z]');
    final hasDigit = RegExp(r'[0-9]');
    final hasSpecialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (content == null || content.isEmpty) return "비밀번호를 입력해주세요.";
    if (content.length < 10 || content.length > 50) return "10자리 이상 50자리 이하여야 합니다.";
    if (!hasUpperCase.hasMatch(content)) return "대문자가 포함되어야 합니다.";
    if (!hasLowerCase.hasMatch(content)) return "소문자가 포함되어야 합니다.";
    if (!hasDigit.hasMatch(content)) return"숫자가 포함되어야 합니다.";
    if (!hasSpecialCharacter.hasMatch(content)) return "특수문자가 포함되어야 합니다.";

    return null;
  }

  static String? checkSamePassword(String? pass1, String? pass2) {
    if (pass1 == null || pass1.isEmpty) return "비밀번호를 입력해주세요.";
    if (pass2 == null || pass2.isEmpty) return "비밀번호를 재입력해주세요.";

    debugPrint('$pass1, $pass2');
    if (pass1 != pass2) return "비밀번호가 다릅니다.";

    return null;
  }
}