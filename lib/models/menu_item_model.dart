import 'package:equatable/equatable.dart';

class MenuItem extends Equatable{
  final int id;
  final int shopId;
  final String name;
  final String description;
  final String imageUrl;

  MenuItem({ required this.id, required this.shopId, required this.name, required this.description, required this.imageUrl});

  @override
  // TODO: implement props
  List<Object?> get props => [id, shopId, name, description, imageUrl];

  static List<MenuItem> menuItems= [
    MenuItem(id: 1, shopId: 1, name: 'Potatoes', description: 'Fresh, 3 baskets', imageUrl: 'https://images.unsplash.com/photo-1603048719539-9ecb4aa395e3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1184&q=80'),
    MenuItem(id: 2, shopId: 3, name: 'Soup', description: '1 liter of fresh soup', imageUrl: 'https://images.unsplash.com/photo-1612966948332-81d747414a8f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
    MenuItem(id: 3, shopId: 2, name: 'Apples', description: '2. class aplles', imageUrl: 'https://images.unsplash.com/photo-1603519346445-c325bc42f27b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80'),
  ];


}