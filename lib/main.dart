import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dravel/controller/controller_auth.dart';
import 'package:dravel/pages/account/page_login.dart';
import 'package:dravel/pages/page_main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'utils/util_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = FlutterSecureStorage();
  await storage.delete(key: 'access');
  await storage.delete(key: 'refresh');

  if (!await storage.containsKey(key: 'device_id')) {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String device_id;
    if (Platform.isAndroid) {
      final infoPlugin = await deviceInfoPlugin.androidInfo;
      device_id = infoPlugin.id;
      device_id += '_${infoPlugin.device}';
    } else {
      final infoPlugin = await deviceInfoPlugin.iosInfo;
      device_id = infoPlugin.identifierForVendor ?? generateRandomString(24);
      device_id += '_${infoPlugin.name}';
    }
    debugPrint('Device Id: $device_id');
    await storage.write(key: 'device_id', value: device_id);
  }

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
