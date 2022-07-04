import 'package:flutter/material.dart';
import 'package:food_app/widgets/shop_tags.dart';

import '../models/shop_model.dart';
import '../models/user_model.dart';

class ShopInformation extends StatelessWidget {
  final User shop;
  const ShopInformation({
    Key? key,
    required this.shop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            shop.name,
            style: Theme.of(context).textTheme.headline3!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //ShopTags(shop: shop),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Shop Information',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            shop.description!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
