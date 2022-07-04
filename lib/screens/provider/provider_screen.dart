import 'package:flutter/material.dart';
import 'package:food_app/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/auth.dart';


class ProviderScreen extends StatefulWidget {
  static const String routeName = '/';


  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ProviderScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<ProviderScreen> createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {

  final AuthAPI _authAPI = AuthAPI();




  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: const Text('Provider page')),
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
              title: const Text('Provider Page'),
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
