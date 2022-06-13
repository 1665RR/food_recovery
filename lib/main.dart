import 'package:flutter/material.dart';
import 'package:food_app/config/theme.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/splash/splash.dart';

import 'config/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Save Food',
      theme: theme(),
    onGenerateRoute: AppRouter.onGenerateRoute,
      //initialRoute: HomeScreen.routeName,
      home: const SplashScreen(title: 'Login UI',),
    );
  }
}


