import 'package:flutter/material.dart';
import 'package:food_app/screens/login/login.dart';
import 'package:food_app/screens/provider/CRUDproducts/addProduct.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_services.dart';
import '../../api/auth.dart';
import 'package:food_app/models/menu_item_model.dart' as itemMenu;

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
  late List<itemMenu.MenuItem>? _products = [];
  final AuthAPI _authAPI = AuthAPI();

  @override
  void initState() {
    super.initState();
    _fetchMyProduct();
  }

  Future _fetchMyProduct() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var sharedToken = sharedPreferences.getString('token');
    _products = (await ApiService().fetchMyProducts(sharedToken!));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: const Text('Provider panel')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'My Products',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _products == null ? 0 : _products!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/product-orders',
                      arguments: _products?[index].id,
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "http://10.0.2.2:8080/${_products![index].photo!.replaceAll(r'\', r'/')}"),
                    ),
                    title: Text(_products![index].name),
                    subtitle: Text(_products![index].description!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () async {
                              final SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              var sharedToken =
                                  sharedPreferences.getString('token');
                              try {
                                var req = await ApiService().deleteProducts(
                                    sharedToken!, _products![index].id);
                                if (req.statusCode == 200) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Product deleted successfully!')));
                                  _fetchMyProduct();
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
                            builder: (context) => AddProductWidget()),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
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
