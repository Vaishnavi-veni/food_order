abstract class CartEvent {}

class AddToCart extends CartEvent {
  final int itemId;
  final int quantity;
  AddToCart({required this.itemId, required this.quantity});
}

class RemoveFromCart extends CartEvent {
  final int itemId;
  RemoveFromCart(this.itemId);
}
