import 'package:equatable/equatable.dart';
import 'package:food_app/models/menu_item_model.dart' as itemMenu;

class Basket extends Equatable{
   final List<itemMenu.MenuItem> items;

   Basket ({
     this.items = const <itemMenu.MenuItem>[],
   });

  Basket copyWith({
    List<itemMenu.MenuItem>? items,
}){
    return Basket(
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [items];

  Map itemQuantity(items){
    var quantity = Map();
    items.forEach((item){
      if(!quantity.containsKey(item)){
        quantity[item] = 1;
      }
      else{
        quantity[item] += 1;
      }
    });
    return quantity;
  }

}