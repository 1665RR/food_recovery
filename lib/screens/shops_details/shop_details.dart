import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/api/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/basket/basket_bloc.dart';
import '../../models/shop_model.dart';
import '../../models/user_model.dart';
import '../../widgets/shop_information.dart';

class ShopDetailsScreen extends StatefulWidget {
  const ShopDetailsScreen({
    Key? key,
    required this.shop,
  }) : super(key: key);

  static const String routeName = '/shop-details';

  static Route route({required User shop}) {
    print("shop $shop");
    return MaterialPageRoute(
      builder: (_) => ShopDetailsScreen(shop: shop),
      settings: const RouteSettings(name: routeName),
    );
  }

  final User shop;

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
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
                onPressed: () async {
                  Navigator.pushNamed(context, '/basket');
                },
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
                  image: NetworkImage("http://10.0.2.2:8080/${widget.shop.photo!.replaceAll(r'\', r'/')}"),
                ),
              ),
            ),
            ShopInformation(shop: widget.shop),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.shop.menuItem?.length ?? 0,
              itemBuilder: (context, index) {
                return _buildMenuItems(widget.shop, context, index);
              },
           ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems(User shop, BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        //   child: Text(
        //     shop.tags[index],
        //     style: Theme.of(context).textTheme.headline3!.copyWith(
        //       color: Theme.of(context).colorScheme.secondary,
        //     ),
        //   ),
        // ),
        Column(
          children: shop.menuItem!
              .map(
                (menuItem) => Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(menuItem.name,
                        style: Theme.of(context).textTheme.headline5),
                    subtitle: Text(menuItem.description!,
                        style: Theme.of(context).textTheme.bodyText1),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height:150,
                          width: 40,
                          child: Builder(
                            builder: (BuildContext context) {
                              return IconButton(
                                icon: Icon(
                                  Icons.add_circle,
                                  color:
                                  Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () async {
                                  final SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                                  var sharedToken = sharedPreferences.getString('token');
                                  try {
                                    var req =
                                    await ApiService().postOrders(sharedToken!,menuItem.id, 1);
                                    if (req.statusCode == 200) {
                                      print("Order succesfully added");
                                    } else {
                                      print(req.body);
                                    }
                                  } on Exception catch (e) {
                                    print(e.toString());
                                    print('catched error');
                                  }
                                 // context.read<BasketBloc>().add(AddItem(menuItem));
                                },
                              );
                            },
                          ),
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
          )
              .toList(),
        ),
      ],
    );
  }
}
