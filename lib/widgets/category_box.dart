import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/shop_model.dart';

class CategoryBox extends StatelessWidget {
  final Category category;
  const CategoryBox({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Shop> shops = Shop.shops
    .where((shop) => shop.tags.contains(category.name),)
    .toList();
    return InkWell(
      onTap: (){
        Navigator.pushNamed(
            context, '/shop-listing',
            arguments: shops);
      },
      child:Container(
      width: 88,
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Stack(
        children: [
          Positioned(
            top:10,
            left: 15,
            child: Container(
              height: 60,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: category.image,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                category.name,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}