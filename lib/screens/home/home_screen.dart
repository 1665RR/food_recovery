import 'package:flutter/material.dart';
import 'package:food_app/models/category_model.dart';
import 'package:food_app/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/auth.dart';
import '../../api/api_services.dart';
import '../../models/promo_model.dart';
import '../../models/user_model.dart';
import '../../widgets/category_box.dart';
import '../../widgets/promo_box.dart';
import '../../widgets/shop_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthAPI _authAPI = AuthAPI();

  late List<Category>? _categories = [];
  late List<User>? _providers = [];
  late List<User>? _searchProviders = [];

  @override
  void initState() {
    super.initState();
    _getCategories();
    _getProviders();
  }

  onSearch(String search) {
    setState(() {
      _searchProviders = _providers!
          .where((user) => user.name.toLowerCase().contains(search))
          .toList();
    });
  }

  void _getCategories() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var sharedToken = sharedPreferences.getString('token');
    _categories = (await ApiService().fetchCategories(sharedToken!));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _getProviders() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var sharedToken = sharedPreferences.getString('token');
    _providers = (await ApiService().fetchProviders(sharedToken!));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: const Text('Home page')),
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
                      return CategoryBox(category: _categories![index]);
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 125,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: Promo.promos.length,
                    itemBuilder: (context, index) {
                      return PromoBox(promo: Promo.promos[index]);
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => onSearch(value),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search for food',
                        suffixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColor,
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 20.0,
                          bottom: 5.0,
                          top: 12.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Newly added',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            _searchProviders!.isEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _providers!.length,
                    itemBuilder: (context, index) {
                      return ShopCard(shop: _providers![index]);
                    },
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _searchProviders!.length,
                    itemBuilder: (context, index) {
                      return ShopCard(shop: _searchProviders![index]);
                    },
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
              child: Text('2Good2Throw'),
            ),
            ListTile(
              title: const Text('Home Page'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('Log Out'),
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
            const SizedBox(
              height: 270,
            ),
            const SizedBox(
              height: 15.0,
              child: Text(
                "Are you shop owner?",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 15.0,
              child: Text(
                "Send e-mail to become provider.",
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                var sharedToken = sharedPreferences.getString('token');
                try {
                  var req = await ApiService().sendEmail(sharedToken!);
                  if (req.statusCode == 200) {
                    print("Success");
                  } else {
                    print(req.statusCode);
                  }
                } on Exception catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              child: const Text("Send email"),
            ),
          ],
        ),
      ),
    );
  }
}
