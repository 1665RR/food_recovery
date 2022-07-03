import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

List<MenuItem> menuItemModelFromJson(String str) =>
    List<MenuItem>.from(json.decode(str).map((x) => MenuItem.fromJson(x)));



class MenuItem extends Equatable{
  final int id;
  final int ? shopId;
  final String name;
  final String ? description;
  final String ? photo;
  final String  ? expire;
  final bool  ? status;
//  final Category category;

  MenuItem({ required this.id,  required this.expire,  required this.status, required this.shopId, required this.name, required this.description, required this.photo,});

  @override
  // TODO: implement props
  List<Object?> get props => [id, shopId, name, description,photo, expire, status];

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
    id: json["Id"],
    name: json["Name"],
    shopId: json["UserId"],
    status: json["Status"],
    photo: json["Photo"],
    expire: json["Expire"],
    description: json["Description"],
  //  category: Category.fromJson(json["Category"]),
  );

  Map<String, dynamic> toJson() => {
    "Id": id == null ? null : id,
    "Name": name == null ? null : name,
  };

  // static List<MenuItem> menuItems= [
  //   MenuItem(id: 1, shopId: 1, name: 'Potatoes', description: 'Fresh, 3 baskets', imageUrl: 'https://images.unsplash.com/photo-1603048719539-9ecb4aa395e3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1184&q=80', category: 'Vegetables'),
  //   MenuItem(id: 2, shopId: 3, name: 'Soup', description: '1 liter of fresh soup', imageUrl: 'https://images.unsplash.com/photo-1612966948332-81d747414a8f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80', category: 'Meals'),
  //   MenuItem(id: 3, shopId: 2, name: 'Apples', description: '2. class apples', imageUrl: 'https://images.unsplash.com/photo-1603519346445-c325bc42f27b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80', category: 'Fruits'),
  //   MenuItem(id: 4, shopId: 1, name: 'Oranges', description: 'Fresh, 2 baskets', imageUrl: 'https://images.unsplash.com/photo-1603048719539-9ecb4aa395e3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1184&q=80', category: 'Fruits'),
  // ];


}