import 'package:flutter/material.dart';
import 'package:food_app/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_services.dart';
import '../../api/auth.dart';
import '../../models/category_model.dart';
import '../../models/user_model.dart';
import 'categories/categories_add.dart';
import 'categories/category_container.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => AdminScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AuthAPI _authAPI = AuthAPI();
  late List<Category>? _categories = [];
  late List<User> _users = [];

  void _getCategories() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var sharedToken = sharedPreferences.getString('token');
    _categories = (await ApiService().fetchCategories(sharedToken!));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _getUsers() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var sharedToken = sharedPreferences.getString('token');
    _users = (await ApiService().fetchUsersList(sharedToken!));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    _getCategories();
    _getUsers();
  }
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      appBar: AppBar(title: const Text('Admin page')),
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
                    itemCount: _categories!.length,
                    itemBuilder: (context, index) {
                      return CategoryDetails(category: _categories![index]);
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCategoryWidget()),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Users',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _users == null ? 0 : _users.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: InkWell(
                      onTap: () {
                      },
                      child: ListTile(
                        title: Text(_users[index].name),
                        subtitle: Text(_users[index].email!),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 10),
                                Text(_users[index].phone.toString(),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .headline6),
                                const SizedBox(height: 5),
                                Text(
                                  _users[index].address!,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline5,
                                ),
                              ],
                            ),
                            const SizedBox(width: 5,),
                           //  _users[index].role![0].id == 1
                           //      ?
                           // TextButton(
                           //     onPressed: () async {
                           //       final SharedPreferences sharedPreferences =
                           //       await SharedPreferences.getInstance();
                           //       var sharedToken = sharedPreferences.getString('token');
                           //       try {
                           //         var req = await ApiService().addToProvider(sharedToken!, _users[index].email!);
                           //         if (req.statusCode == 200) {
                           //           ScaffoldMessenger.of(context).showSnackBar(
                           //               const SnackBar(
                           //                   content: Text(
                           //                       'User added to providers!')));
                           //           _getUsers();
                           //         } else {
                           //           print(req.statusCode);
                           //         }
                           //       } on Exception catch (e) {
                           //         print(e);
                           //       }
                           //     },
                           //     child: Text("ADD"),
                           // )
                           //      :
                                SizedBox(width: 40, child: Text(
                                "${_users[index].role![0].name}")),
                            IconButton(
                                onPressed: () async {
                                  final SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                                  var sharedToken =
                                  sharedPreferences.getString('token');
                                  try {
                                    var req = await ApiService().deleteUsers(
                                        sharedToken!, _users[index].id!);
                                    if (req.statusCode == 200) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'User deleted successfully!')));
                                      _getUsers();
                                    } else {
                                      print(req.body);
                                    }
                                  } on Exception catch (e) {
                                    print(e.toString());
                                    print('catched error');
                                  }
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    ));
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
              title: const Text('Admin Page'),
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
