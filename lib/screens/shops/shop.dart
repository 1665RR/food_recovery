import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  static const String routeName='/shop';

  static Route route(){
    return MaterialPageRoute(
      builder: (_) => const ShopScreen(),
      settings: const RouteSettings(name:routeName),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
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
