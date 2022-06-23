import 'dart:convert';

import 'package:equatable/equatable.dart';

class User {
  int? id;
  String? email;
  String? address;
  String? name;
  String token;

  User({this.id, this.email, this.address, this.name, required this.token});

  factory User.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return User(
      id: json['id'],
      email: json['email'],
      name: json['username'],
      token: json['accessToken'],
      address: json['address'],
    );
  }

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