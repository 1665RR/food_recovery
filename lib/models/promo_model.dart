import 'package:equatable/equatable.dart';

class Promo extends Equatable{
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  Promo({ required this.id, required this.title, required this.description, required this.imageUrl});

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    imageUrl,
  ];

  static List <Promo> promos = [
    Promo(id: 1, title: 'Tomato sale every day.', description: 'Some things some thins asdf apodaf sada amvod scdxd j d sccsdsd dxddscdsxc.', imageUrl: 'https://images.unsplash.com/photo-1594057687713-5fd14eed1c17?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=327&q=80'),
    Promo(id: 2, title: 'Mfd sjnjs f vdfsd eonvdfd.', description: 'Some things some thins asdf apodaf dxddscdsxc.', imageUrl: 'https://images.unsplash.com/photo-1516002484455-c1618f088baa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
  ];


}