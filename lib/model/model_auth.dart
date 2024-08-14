class RegisterModel {
  String name;
  String id;
  String email;
  String password;
  int? age;
  String? drone;

  RegisterModel({
    required this.name,
    required this.id,
    required this.email,
    required this.password,
    this.age,
    this.drone,
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
      "one_liner": null
    };
  }
}