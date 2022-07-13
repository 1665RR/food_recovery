import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Category> categoryModelFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

class Category extends Equatable {
  final int id;
  final String name;
  final String image;

  const Category({required this.id, required this.name, required this.image});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, image];

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["Id"],
        name: json["Name"],
        image: json["Icon"],
      );
}
