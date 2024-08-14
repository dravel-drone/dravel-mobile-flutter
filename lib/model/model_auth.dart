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
}