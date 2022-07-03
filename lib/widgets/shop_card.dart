import 'package:flutter/material.dart';
import 'package:food_app/api/api.dart';
import 'package:food_app/api/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../models/user_model.dart';

class ShopCard extends StatefulWidget {
  final User shop;
   ShopCard({Key? key, required this.shop}) : super(key: key);

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
   User ? _details;

  @override
  void initState(){
    super.initState();
  }

  Future _fetchDetails() async{
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var sharedToken = sharedPreferences.getString('token');
    print("ID:${widget.shop.id}");
    _details = (await ApiService().fetchDetails(sharedToken!, widget.shop.id!));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: () async{
        await _fetchDetails();
        print(_details!.menuItem?.length);
        Navigator.pushNamed(
            context,
            '/shop-details',
            arguments:  _details ?? 0,
        );
      },

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      image: NetworkImage("http://10.0.2.2:8080/${widget.shop.photo!.replaceAll(r'\', r'/')}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.shop.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 5),
                  Text(widget.shop.address!),
                  const SizedBox(height: 5),
                  //ShopTags(shop:shop),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}