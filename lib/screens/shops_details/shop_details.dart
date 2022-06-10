import 'package:flutter/material.dart';

import '../../models/shop_model.dart';
import '../../widgets/shop_information.dart';

class ShopDetailsScreen extends StatelessWidget {
  const ShopDetailsScreen({Key? key, required this.shop,}) : super(key: key);

  static const String routeName = '/shop-details';

  static Route route({required Shop shop}) {
    return MaterialPageRoute(
      builder: (_) =>  ShopDetailsScreen(shop:shop),
      settings: const RouteSettings(name: routeName),
    );
  }
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                ),
                onPressed: () {},
                child: const Text('Basket'),
              )
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom:
                      Radius.elliptical(MediaQuery.of(context).size.width, 55),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(shop.imageUrl),
                ),
              ),
            ),
            ShopInformation(shop: shop),
            ListView.builder(
              padding:  EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: shop.tags.length,
              itemBuilder: (context, index) {
                return _buildMenuItems(shop, context, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems(Shop shop, BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(
            shop.tags[index],
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ),
        Column(
          children: shop.menuItems
              .where((menuItem) => menuItem.category == shop.tags[index])
              .map((menuItem) => Column(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: ListTile(
                          dense:true,
                          contentPadding: EdgeInsets.zero,
                          title: Text(menuItem.name,
                              style:Theme.of(context).textTheme.headline5
                          ),
                          subtitle: Text(menuItem.description,
                              style:Theme.of(context).textTheme.bodyText1
                          ),
                          trailing: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 2,
                      ),
                    ],
                  ),
          ).toList(),
        ),
      ],
    );
  }
}
