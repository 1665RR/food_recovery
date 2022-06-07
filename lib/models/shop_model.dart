import 'package:equatable/equatable.dart';
import 'package:food_app/models/menu_item_model.dart';

class Shop extends Equatable{
  final int id;
  final String imageUrl;
  final String name;
  final String address;
  final String deliveryTime;
  final String date;
  final List<MenuItem> menuItems;
  //final double distance;

  const Shop({ required this.id, required this.imageUrl, required this.address, required this.name, required this.deliveryTime, required this.date, required this.menuItems,});

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    imageUrl,
    name,
    address,
    deliveryTime,
    date,
    menuItems,
  ];

  static List<Shop> shops =[
     Shop(id: 1, imageUrl: 'https://images.unsplash.com/photo-1583564345817-9735ebbc0569?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=433&q=80', name: 'Konzum', address:'Example 123, City Z',deliveryTime: '13.00-19.00', date: '01.06.2022.', menuItems: MenuItem.menuItems.where((menuItem) => menuItem.shopId == 1).toList()),
     Shop(id: 2, imageUrl: 'https://images.unsplash.com/photo-1592973379832-7cb6feae2b9d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80', name: 'Lidl',address:'Example 1d, City ABC', deliveryTime: '13.00-15.00', date: '02.06.2022.',  menuItems: MenuItem.menuItems.where((menuItem) => menuItem.shopId == 2).toList()),
     Shop(id: 3, imageUrl: 'https://images.unsplash.com/photo-1559304822-9eb2813c9844?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=511&q=80', name: 'Fine Food',address:'Example Address, Lost City', deliveryTime: '13.00-17.00', date: '01.06.2022.',  menuItems: MenuItem.menuItems.where((menuItem) => menuItem.shopId == 3).toList()),

  ];



}