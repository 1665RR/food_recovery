import 'package:equatable/equatable.dart';

class Promo extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  const Promo(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl});

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
      ];

  static List<Promo> promos = [
    const Promo(
        id: 1,
        title: 'Food that is too good to throw',
        description:
            'Using our app you help reduce food waste as well as eat healthier and cheaper!',
        imageUrl:
            'https://images.unsplash.com/photo-1606787366850-de6330128bfc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
    const Promo(
        id: 2,
        title: 'Fresh food every day',
        description:
            'Collection of fresh food every day available for everyone.',
        imageUrl:
            'https://images.unsplash.com/photo-1594057687713-5fd14eed1c17?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=327&q=80'),
  ];
}
