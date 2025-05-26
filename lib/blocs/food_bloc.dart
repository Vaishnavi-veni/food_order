// food_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'food_event.dart';
import 'food_state.dart';
import '../../models/food_item.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final List<FoodItem> allItems;

  FoodBloc({required this.allItems})
      : super(FoodState(seeMore: false, filteredItems: allItems.take(4).toList())) {
    on<ToggleSeeMoreEvent>((event, emit) {
      final seeMore = !state.seeMore;
      emit(state.copyWith(
        seeMore: seeMore,
        filteredItems: seeMore ? allItems : allItems.take(4).toList(),
      ));
    });

    on<SearchFoodEvent>((event, emit) {
      final filtered = allItems
          .where((item) =>
              item.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(state.copyWith(
        filteredItems:
            state.seeMore ? filtered : filtered.take(4).toList(),
      ));
    });
  }
}
