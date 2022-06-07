import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/basket/basket.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/location//location_screen.dart';
import 'package:food_app/screens/shops_details/shop_details.dart';

import '../screens/filter/filter.dart';
import '../screens/shops/shop.dart';

class AppRouter{
  static Route onGenerateRoute(RouteSettings settings) {
    print('The route is: ${settings.name}');

    switch(settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case LocationScreen.routeName:
        return LocationScreen.route();
      case FilterScreen.routeName:
        return FilterScreen.route();
      case ShopScreen.routeName:
        return ShopScreen.route();
      case ShopDetailsScreen.routeName:
        return ShopDetailsScreen.route();
      case BasketScreen.routeName:
        return BasketScreen.route();
        break;
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