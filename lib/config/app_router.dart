import 'package:flutter/material.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/screens/basket/basket.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/shops_details/shop_details.dart';

import '../screens/filter/filter.dart';
import '../screens/provider/providersOrders.dart';
import '../screens/shop_listing/shop_listing_screen.dart';
import '../screens/shops/shop.dart';

class AppRouter{
  static Route onGenerateRoute(RouteSettings settings) {
    print('The route is: ${settings.name}');

    switch(settings.name) {
      case '/':
        return HomeScreen.route();
      case FilterScreen.routeName:
        return FilterScreen.route();
      case ShopScreen.routeName:
        return ShopScreen.route();
      case ShopDetailsScreen.routeName:
        return ShopDetailsScreen.route(
          shop:settings.arguments as User,
        );
      case ProductOrdersScreen.routeName:
        return ProductOrdersScreen.route(
          id:settings.arguments as int,
        );
      case BasketScreen.routeName:
        return BasketScreen.route();
      case ShopListing.routeName:
        return ShopListing.route(
          shops: settings.arguments as List<User>
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute(){
    return MaterialPageRoute(
      builder: (_) => Scaffold(appBar: AppBar(title: const Text('error'))),
      settings: const RouteSettings(name:'/error'),
    );
  }

}