import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Category> categoryModelFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));



class Category extends Equatable{
  final int  id;
  final String name;
  final String image;

  const Category({required this.id, required this.name, required this.image });

  @override
  // TODO: implement props
  List<Object?> get props => [id,name, image];
  
  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["Id"],
    name: json["Name"],
    image: json["Icon"],
  );


  // static List<Category> categories =[
  //   Category(id: 1, name: 'Meals', image: Image.asset('assets/meals.png')),
  //   Category(id: 2, name: 'Vegetables', image: Image.asset('assets/vegetable.png')),
  //   Category(id: 3, name: 'Fruits', image: Image.asset('assets/fruit.png')),
  //   Category(id: 4, name: 'Meat', image: Image.asset('assets/meat.png')),
  //   Category(id: 5, name: 'Meals', image: Image.asset('assets/meals.png')),
  //
  // ];

}


