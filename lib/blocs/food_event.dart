// food_event.dart
abstract class FoodEvent {}

class ToggleSeeMoreEvent extends FoodEvent {}

class SearchFoodEvent extends FoodEvent {
  final String query;
  SearchFoodEvent(this.query);
}
