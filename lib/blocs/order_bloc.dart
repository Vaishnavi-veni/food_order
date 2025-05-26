import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final Map<String, double> addOnPrices = {
    'cheese': 1.5,
    'bacon': 2.0,
    'mushrooms': 1.0,
    'onions': 0.75,
    // Add all your add-ons with their prices
  };
  OrderBloc() : super(OrderState.initial()) {
    // Handle tip change
    on<SetTipEvent>((event, emit) {
      emit(state.copyWith(tipAmount: event.tip));
    });

    // Handle add-on toggle
    on<ToggleAddOn>((event, emit) {
      final currentAddOns = List<String>.from(state.selectedAddOns);
      double currentPrice = state.addOnsPrice;

      if (currentAddOns.contains(event.addOn)) {
        currentAddOns.remove(event.addOn);
        currentPrice -= addOnPrices[event.addOn] ?? 0.0;
      } else {
        if (currentAddOns.length < 4) {
          currentAddOns.add(event.addOn);
          currentPrice += addOnPrices[event.addOn] ?? 0.0;
        }
      }

      // Make sure price doesn't go below zero
      if (currentPrice < 0) currentPrice = 0.0;

      emit(state.copyWith(
        selectedAddOns: currentAddOns,
        addOnsPrice: currentPrice,
      ));
    });

    // Handle increase quantity
    on<IncreaseQuantity>((event, emit) {
      emit(state.copyWith(quantity: state.quantity + 1));
    });

    // Handle decrease quantity
    on<DecreaseQuantity>((event, emit) {
      if (state.quantity > 1) {
        emit(state.copyWith(quantity: state.quantity - 1));
      }
    });
  }
}
