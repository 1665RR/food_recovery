import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/category_model.dart';
import 'package:food_app/widgets/food_search.dart';

import '../../models/promo_model.dart';
import '../../models/shop_model.dart';
import '../../widgets/category_box.dart';
import '../../widgets/promo_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: Category.categories.length,
                    itemBuilder: (context, index) {
                      return CategoryBox(category: Category.categories[index]);
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 125,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: Promo.promos.length,
                    itemBuilder: (context, index) {
                      return PromoBox(promo: Promo.promos[index]);
                    }),
              ),
            ),
            FoodSearchBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Newly added',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: Shop.shops.length,
              itemBuilder: (context, index) {
                return ShopCard(shop: Shop.shops[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShopCard extends StatelessWidget {
  final Shop shop;
  const ShopCard({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    image: NetworkImage(shop.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top:10,
                right: 10,
                child: Container(
                  width: 70,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      5.0,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${shop.deliveryTime}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shop.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 5),
                Text(shop.address),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.person),
        onPressed: () {},
      ),
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('HOME PAGE'),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.0);
}
