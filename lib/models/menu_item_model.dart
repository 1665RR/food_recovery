import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

List<MenuItem> menuItemModelFromJson(String str) =>
    List<MenuItem>.from(json.decode(str).map((x) => MenuItem.fromJson(x)));

class MenuItem extends Equatable {
  final int id;
  final int? shopId;
  final String name;
  final String? description;
  final String? photo;
  final String? expire;
  final bool? status;
  final int? itemsLeft;

  MenuItem(
      {required this.id,
      required this.expire,
      required this.status,
      required this.shopId,
      required this.name,
      required this.description,
      required this.photo,
      required this.itemsLeft});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, shopId, name, description, photo, expire, status];

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        id: json["Id"],
        name: json["Name"],
        shopId: json["UserId"],
        status: json["Status"],
        photo: json["Photo"],
        expire: json["Expire"],
        description: json["Description"],
        itemsLeft: json["ItemsLeft"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id == null ? null : id,
        "Name": name == null ? null : name,
      };
}
