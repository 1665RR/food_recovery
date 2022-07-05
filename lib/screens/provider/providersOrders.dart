import 'package:flutter/material.dart';
import 'package:food_app/api/api_services.dart';
import 'package:food_app/models/basket_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';


class ProductOrdersScreen extends StatefulWidget {

   const ProductOrdersScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  static const String routeName = '/product-orders';

  static Route route({required int id}) {
    return MaterialPageRoute(
      builder: (_) => ProductOrdersScreen(id: id),
      settings: const RouteSettings(name: routeName),
    );
  }
  final int id;

  @override
  State<ProductOrdersScreen> createState() => _ProductOrdersScreenState();
}

class _ProductOrdersScreenState extends State<ProductOrdersScreen> {

  List<Basket> ? _orders = [];


  @override
  void initState(){
    super.initState();
    _fetchProductOrders();
  }

  Future _fetchProductOrders() async{
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var sharedToken = sharedPreferences.getString('token');
    _orders = (await ApiService().fetchOrdersByProducts(sharedToken!, widget.id));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    print("orders ${_orders?.length}");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Orders'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _orders!.length,
            itemBuilder: (context, index){
            return _orders!.isEmpty
                ? Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'No Orders for this Product',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            )
                :
              Card(
              child: ListTile(
                subtitle: Text(_orders![index].user!.email!, ),
                title: Text( _orders![index].user!.name, style: Theme.of(context).textTheme.headline4,),
                trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text( _orders![index].address,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(width: 15),
                Text(_orders![index].productQuantity.toString(),
                    style: Theme.of(context).textTheme.headline5
                ),
                const SizedBox(width: 10),
                _orders![index].status ?
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide( color: Colors.grey),
                    backgroundColor: Colors.grey[300],
                  ),
                    onPressed:() {
                }, child: const Text('Taken'))
                    :
                OutlinedButton(onPressed:()async{
                  final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
                  var sharedToken = sharedPreferences.getString('token');
                  try {
                    var req =
                    await ApiService().changeStatus(
                        sharedToken!,
                        _orders![index].id
                    );
                    if (req.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Status changed successfully!')
                          )
                      );
                      _fetchProductOrders();
                    } else {
                      print(req.body);
                    }
                  }on Exception catch (e) {
                    print(e.toString());
                    print('catched error');
                  }
                }, child: const Text('Waiting'))
              ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
