import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/screens/login/login.dart';
import 'package:food_app/screens/provider/provider_screen.dart';
import 'package:food_app/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/auth.dart';
import '../../models/user_model.dart';
import '../admin/admin_screen.dart';

String? finalToken;
String? finalType;

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;
  _SplashScreenState() {
    getValidationData().whenComplete(() async {
      Timer(const Duration(milliseconds: 2000), () {
        setState(() {
          finalToken == null
              ? Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false)
              : {
            if(finalType=="user"){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false)
            }
            else if(finalType=="provider"){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ProviderScreen()),
                      (route) => false)
            }
            else if(finalType=="admin"){
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => AdminScreen()),
                        (route) => false)
              }
          };
        });
      });
    });

    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isVisible = true; //fade effect
      });
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedToken = sharedPreferences.getString('token');
    var obtainedType = sharedPreferences.getString('type');
    setState(() {
      finalToken = obtainedToken;
      finalType = obtainedType;
    });
    print(finalToken);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).primaryColor
          ],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 140.0,
            width: 140.0,
            child: const Center(
              child: ClipOval(
                child: Icon(
                  Icons.soup_kitchen_outlined,
                  size: 128,
                ),
              ),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 2.0,
                    offset: const Offset(5.0, 3.0),
                    spreadRadius: 2.0,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
