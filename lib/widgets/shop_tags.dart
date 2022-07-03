// import 'package:flutter/material.dart';
//
// import '../models/shop_model.dart';
//
// class ShopTags extends StatelessWidget {
//   const ShopTags({Key? key,
//   required this.shop,
//   }) : super(key: key);
//
//   final Shop shop;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: shop.tags
//       .map((tag) => shop.tags.indexOf(tag) ==
//                     shop.tags.length-1
//           ? Text(
//         tag,
//         style: Theme.of(context).textTheme.bodyText1,
//       )
//           : Text(
//         '$tag,',
//         style: Theme.of(context).textTheme.bodyText1,
//       ),
//       ).toList(),
//     );
//   }
// }
