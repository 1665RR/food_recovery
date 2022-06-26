import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/category_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/screens/login/login.dart';
import 'package:food_app/widgets/food_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/auth.dart';
import '../../models/promo_model.dart';
import '../../models/shop_model.dart';
import '../../widgets/category_box.dart';
import '../../widgets/promo_box.dart';
import '../../widgets/shop_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  final AuthAPI _authAPI = AuthAPI();
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => HomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: const Text('Home page')),
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
            const FoodSearchBox(),
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: Shop.shops.length,
              itemBuilder: (context, index) {
                return ShopCard(shop: Shop.shops[index]);
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text('User 1.'),
            ),
            ListTile(
              title: const Text('Home Page'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('Log Out'),
              onPressed: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                var sharedToken = sharedPreferences.getString('token');
                try {
                  var req = await _authAPI.logout(sharedToken!);
                  if (req.statusCode == 204) {
                    sharedPreferences.remove('token');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  } else {
                    print(req.statusCode);
                  }
                } on Exception catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
