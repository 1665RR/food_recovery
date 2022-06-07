import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable{
  final int id;
  final String name;
  final Image image;

  const Category({required this.id, required this.name, required this.image,});

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,image];

  static List<Category> categories =[
    Category(id: 1, name: 'Meals', image: Image.asset('assets/meals.png')),
    Category(id: 2, name: 'Vegetables', image: Image.asset('assets/vegetable.png')),
    Category(id: 3, name: 'Fruits', image: Image.asset('assets/fruit.png')),
    Category(id: 4, name: 'Meat', image: Image.asset('assets/meat.png')),
    Category(id: 5, name: 'Meals', image: Image.asset('assets/meals.png')),

  ];

}


