import 'package:flutter/material.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/widgets/shop_tags.dart';

class ShopCard extends StatelessWidget {
  final Shop shop;
  const ShopCard({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(
            context,
            '/shop-details',
            arguments:shop,
        );
      },
      child: Padding(
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
                  ShopTags(shop:shop),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}