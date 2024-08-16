import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/pages/account/page_login.dart';
import 'package:dravel/pages/page_main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = FlutterSecureStorage();
  await storage.delete(key: 'access');
  await storage.delete(key: 'refresh');
  Get.put(AuthController());
  final controller = Get.find<AuthController>();
  runApp(MyApp(
    isLogin: await controller.checkLogin(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({
    required this.isLogin,
    super.key
  });

  bool isLogin;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'Pretendard'
      ),
      home: isLogin ? MainNavigationPage() : LoginPage(),
    );
  }
}
