import 'package:dravel/model/model_term.dart';

class RegisterModel {
  String name;
  String id;
  String email;
  String password;
  int? age;
  String? drone;
  List<int> agreeTerm;

  RegisterModel({
    required this.name,
    required this.id,
    required this.email,
    required this.password,
    this.age,
    this.drone,
    this.agreeTerm = const []
  });

  Map<String, dynamic> toJson() {
    return {
      "user": {
        "name": name,
        "id": id,
        "email": email,
        "password": password,
        "age": age,
        "drone": drone,
        "image": null,
        "one_liner": null
      },
      "agreed_term_ids": agreeTerm
    };
  }
}

class LoginModel {
  String id;
  String password;
  String deviceId;

  LoginModel({
    required this.id,
    required this.password,
    required this.deviceId
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'device_id': deviceId
    };
  }
}

class AuthKeyModel {
  String accessKey;
  String refreshKey;

  AuthKeyModel({
    required this.accessKey,
    required this.refreshKey,
  });
}

class LoginUserModel {
  String uid;
  String name;
  String id;
  String email;
  int isAdmin;
  int age;
  String? drone;
  String? imageUrl;
  String? oneLiner;

  LoginUserModel({
    required this.uid,
    required this.name,
    required this.id,
    required this.email,
    required this.isAdmin,
    required this.age,
    required this.drone,
    required this.imageUrl,
    required this.oneLiner,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> data) {
    return LoginUserModel(
        uid: data['uid'],
        name: data['name'],
        id: data['id'],
        email: data['email'],
        isAdmin: data['isAdmin'],
        age: data['age'] ?? 0,
        drone: data['drone'],
        imageUrl: data['image'],
        oneLiner: data['one_liner']
    );
  }
}
