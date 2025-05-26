abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<Map<String, dynamic>> items;
  CartUpdated(this.items);
}