import 'dart:math';

String generateRandomString(int length) {
  const String chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()_+[]{}|;:,.<>?';
  Random random = Random();

  return List.generate(length, (index) {
    return chars[random.nextInt(chars.length)];
  }).join('');
}