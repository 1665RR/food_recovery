import 'package:flutter/material.dart';
import 'package:food_app/api/api_services.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  int quantity = 0;
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
              itemCount: 1,
              itemBuilder: (context, index) {
                print(widget.shop.menuItem?.length);
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
                    horizontal: 10,
                  ),
                  child: ListTile(
                    dense: false,
                    contentPadding: EdgeInsets.zero,
                    title: Text(menuItem.name,
                        style: Theme.of(context).textTheme.headline5),
                    subtitle: Text(menuItem.description!,
                        style: Theme.of(context).textTheme.bodyText1),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 130,
                          height: 200,
                          child: Builder(
                            builder: (BuildContext context) {
                              return (menuItem.itemsLeft! >0 ) ?
                                Row(
                                  children: [
                                    Expanded(
                                      flex:1,
                                      child: NumberInputWithIncrementDecrement(
                                        controller: TextEditingController(),
                                        min: 1,
                                        max: menuItem.itemsLeft!,
                                        onIncrement: (num newlyIncrementedValue) {
                                          quantity = newlyIncrementedValue.toInt();
                                        },
                                        onDecrement: (num newlyDecrementedValue) {
                                          quantity = newlyDecrementedValue.toInt();
                                        },
                                      ),
                                    ),
                                    IconButton(
                                    icon: Icon(
                                      Icons.add_circle,
                                      color:
                                      Theme.of(context).colorScheme.secondary,
                                    ),
                                    onPressed: () async {
                                      final SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                      var sharedToken = sharedPreferences.getString('token');
                                      print('Quantity $quantity');
                                      try {
                                        var req =
                                        await ApiService().postOrders(sharedToken!,menuItem.id, quantity);
                                        if (req.statusCode == 200) {
                                          print("Order successfully added");
                                        } else {
                                          print(req.body);
                                        }
                                      } on Exception catch (e) {
                                        print(e.toString());
                                        print('catched error');
                                      }
                                    },
                              ),
                                  ],
                                )
                              :
                              IconButton(
                                icon: const Icon(
                                  Icons.error,
                                  color:
                                  Colors.grey,
                                ),
                                onPressed: ()  {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'No more Items left')));
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
