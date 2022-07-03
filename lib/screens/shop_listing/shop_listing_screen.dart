import 'package:flutter/material.dart';
import 'package:food_app/widgets/shop_card.dart';

import '../../models/user_model.dart';

class ShopListing extends StatelessWidget {
  const ShopListing({
    Key? key,
    required this.shops,
  }) : super(key: key);

  static const String routeName='/shop-listing';

  static Route route({required List <User> shops}){
    return MaterialPageRoute(
        builder: (_)=> ShopListing(shops:shops),
      settings: const RouteSettings(name:routeName),
    );
  }

  final List <User> shops;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Shops'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: shops.length,
              itemBuilder: (context, index) {
                return ShopCard(shop: shops[index]);
              }
          ),
        )
    );
  }
}
