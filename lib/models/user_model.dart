import 'dart:convert';

import 'menu_item_model.dart';

List<User> shopModelFromJson(String str) =>
    List<User>.from(json.decode(str)
        .map((x) => User.fromJson(x)));

List<User> usersFromJson(String str) =>
    List<User>.from(json.decode(str)
        .map((x) => User.fromJsonUser(x)));

User detailsModelFromJson(String str) => User.fromJsonDetails(json.decode(str));


class User {
  int? id;
  String? email;
  String? address;
  String name;
  String ? token;
  String  ? phone;
  String ? photo;
  String ? description;
  List <MenuItem> ? menuItem;
  List <String> ? roles;
   List<Role> ? role;



  User({this.id, this.email, this.address,  required this.name,  this.token,
     this.phone,  this.photo, this.description, this.menuItem,
     this.roles, this.role
  });

  factory User.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return User(
      id: json['id'],
      email: json['email'],
      name: json['username'],
      token: json['accessToken'],
      address: json['address'],
      phone: json['phone'],
      photo: json['photo'],
      description: json['description'],
      roles: List<String>.from(json['roles'].map((x) => x)),
    );
  }

  factory User.fromJsonUser(Map<String, dynamic> json) => User(
    id: json['Id'],
    email: json['Email'],
    name: json['Username'],
    phone: json['Phone'],
    photo: json['Photo'],
    address: json['Address'],
    role: List<Role>.from(json["Roles"].map((x) => Role.fromJson(x))),
  );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['Id'],
    email: json['Email'],
    name: json['Username'],
    address: json['Address'],
    phone: json['Phone'],
    photo: json['Photo'],
  );

  factory User.fromJsonDetails(Map<String, dynamic> json) => User(
    id: json['Id'],
    email: json['Email'],
    name: json['Username'],
    address: json['Address'],
    phone: json['Phone'],
    photo: json['Photo'],
    description: json['Description'],
    menuItem: List<MenuItem>.from(json["Products"].map((x) => MenuItem.fromJson(x))),
  );



  void printAttributes() {
    print("id: ${this.id}\n");
    print("email: ${this.email}\n");
    print("name: ${this.name}\n");
    print("token: ${this.token}\n");
  }


  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Role {
  Role({
    required this.id,
    required this.name,
    required this.userRoles,
  });

  final int id;
  final String name;
  final UserRoles userRoles;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["Id"],
    name: json["Name"],
    userRoles: UserRoles.fromJson(json["user_roles"]),
  );

}

class UserRoles {
  UserRoles({
    required this.roleId,
    required this.userId,
  });

  final int roleId;
  final int userId;

  factory UserRoles.fromJson(Map<String, dynamic> json) => UserRoles(
    roleId: json["roleId"],
    userId: json["userId"],
  );

}

