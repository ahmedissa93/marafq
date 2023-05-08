import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.role_id,
    required this.token,
  });

  int id;
  String name;
  String username;
  String email;
  int role_id;
  String token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      email: json["email"],
      role_id: json["role_id"],
      token: json["token"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "role_id": role_id,
        "token": token
      };
}
