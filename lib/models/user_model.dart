import 'dart:convert';

import 'menu_item_model.dart';

List<User> shopModelFromJson(String str) =>
    List<User>.from(json.decode(str)
        .map((x) => User.fromJson(x)));



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


  User({this.id, this.email, this.address,  required this.name,  this.token,
     this.phone,  this.photo, this.description, this.menuItem
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
    );
  }

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
