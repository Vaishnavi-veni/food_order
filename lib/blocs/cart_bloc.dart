import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<Map<String, dynamic>> _cart = [];

  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) {
      _cart.add({"id": event.itemId, "qty": event.quantity});
      emit(CartUpdated(_cart));
    });
    on<RemoveFromCart>((event, emit) {
      _cart.removeWhere((item) => item["id"] == event.itemId);
      emit(CartUpdated(_cart));
    });
  }
}
