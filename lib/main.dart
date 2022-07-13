import 'package:flutter/material.dart';
import 'package:food_app/config/theme.dart';
import 'package:food_app/screens/splash/splash.dart';

import 'config/app_router.dart';

void main() async {
  // Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //return MultiBlocProvider(
    //   providers: [
    //     // BlocProvider(
    //     //   create: (context) => BasketBloc()
    //     //     ..add(
    //     //       StartBasket(),
    //     //     ),
    //     // ),
    //   ],
      return MaterialApp(
        title: 'Food Rescue',
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        //initialRoute: HomeScreen.routeName,
        home: SplashScreen(
          title: 'Login UI',
        ),
      );
   // );
  }
}
