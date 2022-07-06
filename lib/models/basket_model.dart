import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:food_app/models/menu_item_model.dart' as itemMenu;
import 'package:food_app/models/user_model.dart';

List<Basket> basketFromJson(String str) => List<Basket>.from(json.decode(str).map((x) => Basket.fromJson(x)));

class Basket extends Equatable{

  // final List<itemMenu.MenuItem> items;

   Basket({
      required this.id,
     required this.productQuantity,
     required this.status,
     required this.address,
     required this.productId,
     required this.userId,
     required this.menuItem,
      this.user,

   });

   final int id;
   final int productId;
   final int productQuantity;
   final bool status;
   final String address;
   final int userId;
   final  itemMenu.MenuItem ? menuItem;
   final User ? user;

   factory Basket.fromJson(Map<String, dynamic> json) => Basket(
     id: json["Id"] == null ? null : json["Id"],
     productQuantity: json["ProductQuantity"] == null ? null : json["ProductQuantity"],
     status: json["Status"] == null ? null : json["Status"],
     address: json["Address"] ?? null,
     productId: json["ProductId"] ?? 0,
     userId: json["UserId"] == null ? null : json["UserId"],
     menuItem: json["Product"] == null ? null : itemMenu.MenuItem.fromJson(json["Product"]),

   );

   factory Basket.fromJsonUser(Map<String, dynamic> json) => Basket(
     id: json["Id"] == null ? null : json["Id"],
     productQuantity: json["ProductQuantity"] == null ? null : json["ProductQuantity"],
     status: json["Status"] == null ? null : json["Status"],
     address: json["Address"] ?? null,
     productId: json["ProductId"] == null ? null : json["ProductId"],
     userId: json["UserId"] == null ? null : json["UserId"],
     menuItem: json["Product"] == null ? null : itemMenu.MenuItem.fromJson(json["Product"]),
     user: User.fromJson(json["User"]) ,
   );

  Map<String, dynamic> toJson() => {
    "id": productId,
    "quantity": productQuantity,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, status,productQuantity, address, userId,productId, menuItem];


  // Map itemQuantity(items){
  //   var quantity = Map();
  //   items.forEach((item){
  //     if(!quantity.containsKey(item)){
  //       quantity[item] = 1;
  //     }
  //     else{
  //       quantity[item] += 1;
  //     }
  //   });
  //   return quantity;
  // }

}