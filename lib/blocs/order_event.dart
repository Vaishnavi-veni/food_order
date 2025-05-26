part of 'order_bloc.dart';

// Tip Events
abstract class OrderEvent {}

class SetTipEvent extends OrderEvent {
  final int tip;
  SetTipEvent(this.tip);
}

// Add-on Events
class ToggleAddOn extends OrderEvent {
  final String addOn;  // <- This must be present
  ToggleAddOn(this.addOn);
}

// Quantity Events
class IncreaseQuantity extends OrderEvent {}

class DecreaseQuantity extends OrderEvent {}
