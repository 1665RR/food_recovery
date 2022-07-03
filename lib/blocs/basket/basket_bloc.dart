// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:food_app/models/menu_item_model.dart' as itemMenu;
//
//
// import '../../models/basket_model.dart';
//
// part 'basket_event.dart';
// part 'basket_state.dart';
//
// class BasketBloc extends Bloc<BasketEvent, BasketState> {
//   BasketBloc() : super(BasketLoading());
//
//   @override
//   Stream<BasketState> mapEventToState(
//     BasketEvent event,
//   ) async* {
//     if (event is StartBasket) {
//       yield* _mapStartBasketToState();
//     } else if (event is AddItem) {
//       yield* _mapAddItemToState(event, state);
//     } else if (event is RemoveItem) {
//       yield* _mapRemoveItemToState(event, state);
//     }
//   }
// }
//
// Stream<BasketState> _mapStartBasketToState() async* {
//   yield BasketLoading();
//   try {
//     await Future<void>.delayed(const Duration(seconds: 1));
//     yield BasketLoaded(basket: Basket());
//   } catch (_) {}
// }
//
// Stream<BasketState> _mapAddItemToState(
//   AddItem event,
//   BasketState state,
// ) async* {
//   if (state is BasketLoaded) {
//     try {
//       yield BasketLoaded(
//           basket: state.basket
//               .copyWith(items: List.from(state.basket.items)..add(event.item),
//           ));
//     } catch (_) {}
//   }
// }
//
// Stream<BasketState> _mapRemoveItemToState(
//   RemoveItem event,
//   BasketState state,
// ) async* {
//   if (state is BasketLoaded) {
//     try {
//       yield BasketLoaded(
//           basket: state.basket
//               .copyWith(items: List.from(state.basket.items)..remove(event.item),
//           ));
//     } catch (_) {}
//   }
// }
