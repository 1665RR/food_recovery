import 'package:flutter/material.dart';

class ShopDetailsScreen extends StatelessWidget {
  const ShopDetailsScreen({Key? key}) : super(key: key);

  static const String routeName='/shop-details';

  static Route route(){
    return MaterialPageRoute(
      builder: (_) => const ShopDetailsScreen(),
      settings: const RouteSettings(name:routeName),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop Details')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Home Screen'),
          onPressed: (){
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
    );
  }
}
