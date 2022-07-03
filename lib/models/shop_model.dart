import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:food_app/models/menu_item_model.dart';
import 'package:food_app/models/user_model.dart';



class Shop extends Equatable{
  final User  ? user;
  final int id;
  final String  ? imageUrl;
  final String  ? name;
  final String  ? address;
  final String  ? email;
  final String  ? phone;
  final String ? userName;
  // final List<MenuItem> menuItems;
  // final List<String> tags;

  const Shop( { this.userName,
    required this.id, required this.imageUrl, required this.address, required this.name, required this.email, required this.phone, required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    imageUrl,
    name,
    address,
    email,
    phone,
    user,
    userName
  ];


  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["Id"],
    name: json["Name"],
    email: json["Email"],
    imageUrl: json["Photo"],
    address: json["Address"],
    phone: json["Phone"],
    user: User.fromJson(json["User"]),
    userName: User.fromJson(json["User"]).name,

  );


  static List<Shop> shops =[
     Shop(
         id: 1,
         imageUrl: 'https://images.unsplash.com/photo-1583564345817-9735ebbc0569?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=433&q=80', name: 'Konzum', address:'Example 123, City Z', phone: 'asas', email: 'ASAS', user: null,

         ),
     Shop(
        id: 2,
       imageUrl: 'https://images.unsplash.com/photo-1592973379832-7cb6feae2b9d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
       name: 'Lidl',
       address:'Example 1d, City ABC', email: 'asas', phone: 'asa', user: null,
        ),
     Shop(id: 3,
         imageUrl: 'https://images.unsplash.com/photo-1559304822-9eb2813c9844?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=511&q=80',
         name: 'Fine Food',
         address:'Example Address, Lost City', email: 'Aa', phone: 'aA',
       user: null,

           ),

  ];



}