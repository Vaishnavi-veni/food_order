// food_state.dart
import '../../models/food_item.dart';

class FoodState {
  final bool seeMore;
  final List<FoodItem> filteredItems;

  FoodState({required this.seeMore, required this.filteredItems});

  FoodState copyWith({bool? seeMore, List<FoodItem>? filteredItems}) {
    return FoodState(
      seeMore: seeMore ?? this.seeMore,
      filteredItems: filteredItems ?? this.filteredItems,
    );
  }
}
