part of 'order_bloc.dart';

class OrderState {
  final int tipAmount;
  final List<String> selectedAddOns;
  final double addOnsPrice;

  final int quantity;

  final bool isCovidChecked;

  const OrderState({
    required this.tipAmount,
    required this.selectedAddOns,
    required this.addOnsPrice,
    required this.quantity,
    required this.isCovidChecked, // new
  });

  factory OrderState.initial() => const OrderState(
        tipAmount: 0,
        selectedAddOns: [],
        addOnsPrice: 0.0,
        quantity: 1,
        isCovidChecked: false, // new
      );

  OrderState copyWith({
    int? tipAmount,
    List<String>? selectedAddOns,
    double? addOnsPrice,
    int? quantity,
    bool? isCovidChecked, // new
  }) {
    return OrderState(
      tipAmount: tipAmount ?? this.tipAmount,
      selectedAddOns: selectedAddOns ?? this.selectedAddOns,
      addOnsPrice: addOnsPrice ?? this.addOnsPrice,
      quantity: quantity ?? this.quantity,
      isCovidChecked: isCovidChecked ?? this.isCovidChecked, // new
    );
  }
}
