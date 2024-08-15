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
      "name": name,
      "id": id,
      "email": email,
      "password": password,
      "age": age,
      "drone": drone,
      "image": null,
      "one_liner": null,
      // "term": agreeTerm
    };
  }
}